#language:zh-CN
功能: 调拨管理
  场景: 创建一个调拨任务
    假如我有一个creatorId为 1、goodsId为 1、num为 1、logisticsType为 2、描述为 "测试记录" 的outRecord调拨对象
    当我调用createOrder函数使用该调拨任务创建出库单
    那么返回的结果应为成功，包含一个outRecord
