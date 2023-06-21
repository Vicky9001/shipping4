#language:zh-CN
功能: 采购管理

  场景:获取采购单列表
    假如我希望获取purchaseRecord
    当我使用type 1 调用getOrder
    那么返回的结果应为成功，包含一组PurchaseRecord，type为 1

  场景:审核采购单
    假如我有一个id为 18 、operator为 1 、remark为 "test" 的Map对象
    当我使用该Map对象调用approveOrder
    那么返回的结果应为采购单审核通过

  场景:获取采购单失败
    假如我希望获取一个purchaseRecord
    当我通过type 90 调用getOrder
    那么返回的结果应为失败

  场景:拒绝采购单审核通过
    假如我使用一个id为 18 、operator为 1 、remark为 "testReject" 的Map对象
    当我使用该Map对象调用rejectOrder
    那么返回的结果应为采购单审核未通过

  场景:拒绝采购单审核通过失败
    假如我有一个id为 14 、operator不合法，为 1000 、remark为 "test" 的Map对象
    当使用该Map对象调用rejectOrder
    那么返回的结果为失败

