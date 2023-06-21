package com.example.controllers;

import com.example.client.UserClient;
import com.example.entity.Order.Transfer;
import com.example.entity.User.ERole;
import com.example.entity.User.Role;
import com.example.entity.User.Van;
import com.example.payload.request.OrderRequest;
import com.example.entity.Order.Order;
import com.example.entity.User.User;
import com.example.repository.*;
import com.example.utils.Result;
import com.example.utils.ResultCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

import static com.example.entity.User.ERole.ROLE_CARRIER;


@RestController
@RequestMapping("/order")
public class OrderController {
	@Resource
	OrderRepository orderRepository;

	@Resource
	UserClient userClient;

	@Resource
	TransferRepository transferRepository;

	@Resource
	VanRepository vanRepository;

	ResultCode resultCode;

	/**
	 * 创建订单
	 * @param orderRequest
	 * @return
	 */
	@PostMapping("/create")
	public ResponseEntity<?> createOrder(@Valid @RequestBody OrderRequest orderRequest) {

		Map<String, Object> response = new HashMap<>();
		User shipper = userClient.findById(orderRequest.getShipperId());
		if (shipper == null) {
			return ResponseEntity
					.badRequest()
					.body(new Result(ResultCode.INFOERR, "Shipper not found!", response));
		}
		int state=0;
		LocalDateTime createDate= LocalDateTime.now();
		System.out.println(orderRequest.getStart());
		Order order = new Order(shipper,
				orderRequest.getStart(),
				orderRequest.getDestination(),
				orderRequest.getReceiver(),
				orderRequest.getInfo(),
				orderRequest.getWeight(),
				state,
				createDate);

		System.out.println(order);
		orderRepository.save(order);

		return ResponseEntity.ok(new Result(ResultCode.SUCCESS, "Success", response));
	}

	/**
	 * 为订单分配车辆和驾驶人，价格
	 * @param orderRequest
	 * @return
	 */
	@PostMapping("/update")
	public ResponseEntity<?> updateOrder(@Valid @RequestBody OrderRequest orderRequest) {
		Order order = orderRepository.findById(orderRequest.getId()).orElse(null);
		order.setMoney(orderRequest.getMoney());
		Map<String, Object> response = new HashMap<>();
		if (order == null) {
			return ResponseEntity.badRequest().body(new Result(ResultCode.INFOERR, "Order not found!", response));
		}

		Set<Long> carrierIds = orderRequest.getCarrierIds();
		Set<User> carriers = new HashSet<User>();

		Set<Long> vanIds = orderRequest.getVanIds();
		Set<Van> vans = new HashSet<Van>();

		for (Long carrierId : carrierIds) {
			User carrier = userClient.findById(carrierId);
			Object c = userClient.findByRoleName(ERole.valueOf("ROLE_CARRIER"));
			if (carrier == null || !carrier.getRoles().contains(c)) {
				return ResponseEntity.badRequest().body(new Result(ResultCode.INFOERR, "Carrier not found!", response));
			}
			carriers.add(carrier);
		}

		for (Long vanId : vanIds) {
			Van van = vanRepository.findById(vanId).orElse(null);
			if (van == null) {
				return ResponseEntity.badRequest().body(new Result(ResultCode.INFOERR, "Carrier not found!", response));
			}
			vans.add(van);
		}
		order.setCarriers(carriers);
		order.setVans(vans);
		order.setState(1);
		order.setMoney(orderRequest.getMoney());
		try {
			orderRepository.save(order);
		} catch (Exception e){
			return ResponseEntity.badRequest().body(new Result(ResultCode.InfoModERR, "修改失败!", response));
		}

		for(Van van: vans) {
			van.setState(1);
			vanRepository.save(van);
		}

		return ResponseEntity.ok(new Result(ResultCode.SUCCESS, "Update successfully!", response));
	}

	@PostMapping("/changeState")
	public ResponseEntity<?> changeState(@Valid @RequestBody OrderRequest orderRequest) {
		Order order = orderRepository.findById(orderRequest.getId()).orElse(null);
		Map<String, Object> response = new HashMap<>();
		if (order == null) {
			return ResponseEntity.badRequest().body(new Result(ResultCode.INFOERR, "Order not found!", response));
		}
		//1-已付款待揽件，2-揽件运输中，3-已交付，4-退货拒收 40-退货待揽件 41-退货运输中 42-退货交付 5-订单结束
		int state = orderRequest.getState();
		order.setState(state);
		orderRepository.save(order);
		return ResponseEntity.ok(new Result(ResultCode.SUCCESS, "Update successfully!", response));
	}

	@PostMapping("/transfer")
	public ResponseEntity<?> transfer(@Valid @RequestBody OrderRequest orderRequest) {
		Order order = orderRepository.findById(orderRequest.getId()).orElse(null);
		Map<String, Object> response = new HashMap<>();
		if (order == null) {
			return ResponseEntity.badRequest().body(new Result(ResultCode.INFOERR, "Order not found!", response));
		}
		if (order.getState() == 0) {
			return ResponseEntity.badRequest().body(new Result(ResultCode.INFOERR, "State of order wrong!", response));
		}

		String loca = orderRequest.getLoca();
		LocalDateTime time = LocalDateTime.now();

		Transfer transfer = new Transfer(order,loca,time);
		transferRepository.save(transfer);

		return ResponseEntity.ok(new Result(ResultCode.SUCCESS, "Update successfully!", response));
	}

	@GetMapping("/searchCarrier")
	public ResponseEntity<?> searchOrdersByCarrierId(@RequestParam(required = false,name = "carrierId") Long carrierId) {
		Result res = new Result();
		// 从userRepository中获取carrier对象
		User carrier = userClient.findById(carrierId);
		Object c = userClient.findByRoleName(ERole.valueOf("ROLE_CARRIER"));
		Map<String, Object> response = new HashMap<>();
		if (carrier == null || !carrier.getRoles().contains(c)) {
			return ResponseEntity.ok(new Result(ResultCode.INFOERR, "Invalid carrier ID", response));
		}
		// 从orderRepository中获取该carrier的所有订单
		List<Order> orders = orderRepository.findByCarriersContaining(carrier);

		if (orders.isEmpty()) {
			return ResponseEntity.ok(new Result(ResultCode.INFOERR, "No orders found for this carrier", response));
		}
		double totalMoney = orders.stream().mapToDouble(Order::getMoney).sum(); // 计算money总和
//		List<Map<String, Object>> ordersList = new ArrayList<>();
//		for (Order order : orders) {
//			Map<String, Object> orderMap = new HashMap<>();
//			orderMap.put("id", order.getId());
//			orderMap.put("from", order.getStart());
//			orderMap.put("to", order.getDestination());
//			orderMap.put("money", order.getMoney());
//			// 其他属性
//			ordersList.add(orderMap);
//		}
		res.setCode(ResultCode.SUCCESS);
		res.setMessage("Success");
		response.put("orders", orders);
		response.put("totalMoney", totalMoney); // 将money总和添加到响应中

		return ResponseEntity.ok(new Result(ResultCode.SUCCESS, "Success", response));
	}

	@GetMapping("/searchId")
	public Result searchOrdersById(@RequestParam(required = false,name = "orderId") Long orderId) {
		Result res = new Result();
		Map<String, Object> response = new HashMap<>();
		Order order = orderRepository.findById(orderId).get();

		if (order==null) {
			res.setCode(ResultCode.EXISTERR);
			res.setMessage(resultCode.getMsg(ResultCode.EXISTERR));
			return res;
		}

		res.setCode(ResultCode.SUCCESS);
		res.setMessage("Success");
		response.put("order",order);
		res.setData(response);

		return res;
	}


	@GetMapping("/searchShipment")
	public ResponseEntity<?> searchShipmentsByOrderId(@RequestParam(required = false,name = "orderId") Long orderId) {
		// 从orderRepository中获取指定订单
		Order order = orderRepository.findById(orderId).orElse(null);
		Map<String, Object> response = new HashMap<>();
		if (order == null) {
			return ResponseEntity.ok(new Result(ResultCode.INFOERR, "Invalid order ID", response));
		}
		// 获取该订单的所有转运记录
		List<Transfer> shipments = transferRepository.findByOrder(order);
		if (shipments.isEmpty()) {
			return ResponseEntity.ok(new Result(ResultCode.INFOERR, "No shipments found for this order", response));
		}
		List<Map<String, Object>> shipList = new ArrayList<>();
		for (Transfer ship : shipments) {
			Map<String, Object> shipMap = new HashMap<>();
			shipMap.put("id", ship.getId());
			shipMap.put("location", ship.getLoca());
			shipMap.put("transferTime", ship.getTransferTime());
			// 其他属性
			shipList.add(shipMap);
		}
		response.put("shipments", shipList);
		return ResponseEntity.ok(new Result(ResultCode.SUCCESS, "Success", response));
	}

	@GetMapping("/orderList")
	public Result queryOrderList( @RequestParam(required = false,name = "shipperName") String shipperName,
								 @RequestParam(required = false,name = "carrierName") String carrierName,
								  @RequestParam(required = false,name = "vanLicense") String vanLicense){
		Result res = new Result();
		Map<String, Object> map = new HashMap<>();
		try{
			List<Order> list = new ArrayList<>();
			if(shipperName.isEmpty() && carrierName.isEmpty() && vanLicense.isEmpty()) {
				list = orderRepository.findAll();
			}
			else{
				List<User> shipper;
				List<User> carrier;
				List<Van> van;
				List<Order> orderShipper=new ArrayList<>();
				List<Order> orderCarrier=new ArrayList<>();
				List<Order> orderVan=new ArrayList<>();
				if(!shipperName.isEmpty()){
					shipper=userClient.findByUsernameContaining(shipperName);
					Optional<Role> optionalRole = (Optional<Role>) userClient.findByRoleName(ERole.ROLE_SHIPPER);
					Role role = optionalRole.orElseThrow(() -> new RuntimeException("Error: Role is not found."));
					Iterator<User> iterator = shipper.iterator();
					while (iterator.hasNext()) {
						User u = iterator.next();
						if (!u.getRoles().contains(role)) {
							iterator.remove();
						}
					}
					for(User u:shipper) {
						List<Order> l=orderRepository.findByShipper(u);
						orderShipper.addAll(l);
					}
					orderShipper = orderShipper.stream().distinct().collect(Collectors.toList());
					System.out.println("1-----------------");
					System.out.println(orderShipper);
				} else {
					orderShipper = orderRepository.findAll();
				}
				if(!carrierName.isEmpty()){
					carrier=userClient.findByUsernameContaining(carrierName);
					Optional<Role> optionalRole = (Optional<Role>) userClient.findByRoleName(ROLE_CARRIER);
					Role role = optionalRole.orElseThrow(() -> new RuntimeException("Error: Role is not found."));
					Iterator<User> iterator = carrier.iterator();

					while (iterator.hasNext()) {
						User u = iterator.next();
						if (!u.getRoles().contains(role)) {
							System.out.println("carrier");
							iterator.remove();
						}
					}
					for(User u:carrier) {
						System.out.println(u);
						List<Order> l=orderRepository.findByCarriersContaining(u);
						System.out.println(l);
						orderCarrier.addAll(l);
					}
					orderCarrier = orderCarrier.stream().distinct().collect(Collectors.toList());
					System.out.println("2-----------------");
					System.out.println(orderCarrier);
				} else {
					orderCarrier = orderRepository.findAll();
				}
				if(!vanLicense.isEmpty()){
					van=vanRepository.findByLicenseContaining(vanLicense);
					for(Van v:van) {
						List<Order> l=orderRepository.findByVansContaining(v);
						orderVan.addAll(l);
					}
					orderVan = orderVan.stream().distinct().collect(Collectors.toList());
				} else {
					orderVan = orderRepository.findAll();
				}
				System.out.println(orderShipper);
				System.out.println(orderCarrier);
				System.out.println(orderVan);
				orderShipper.retainAll(orderCarrier);
				orderShipper.retainAll(orderVan);
				list = orderShipper;
				System.out.println("3----------------");
				System.out.println(list);
			}
			// 去除重复查询
			list = list.stream().distinct().collect(Collectors.toList());
			System.out.println("4----------------");
			System.out.println(list);
//			for(Order l:list){
//				System.out.println(l);
//			}
			map.put("orderList",list);
			res.setMessage("返回成功");
			res.setData(map);
		} catch (Exception e) {
			e.printStackTrace();
			res.setCode(resultCode.ERROR);
			res.setMessage(resultCode.getMsg(resultCode.ERROR));
		}
		return res;
	}

}
