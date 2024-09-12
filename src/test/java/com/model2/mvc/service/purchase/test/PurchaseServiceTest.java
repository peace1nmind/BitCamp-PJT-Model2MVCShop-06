package com.model2.mvc.service.purchase.test;
// W D 

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml",
										"classpath:config/context-transaction.xml"
										})
public class PurchaseServiceTest {

	// Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	
	//@Test
	public void testAddPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		purchase.setPaymentOption("1");
		purchase.setPurchaseProd(productService.getProduct(10008));
		purchase.setBuyer(userService.getUser("user08"));
		purchase.setDlvyDate("240910");
		
		System.out.println("\n==============================");
		purchaseService.addPurchase(purchase);
		System.out.println("==============================\n");
	}
	
	
	@Test
	public void testGetPurchase() {
		
		System.out.println("\n==============================");
		Purchase purchase = purchaseService.getPurchase(10003);
		System.out.println(purchase);
		System.out.println("\t\t"+purchase.getPurchaseProd());
		System.out.println("==============================\n");
	}
	
	
	//@Test
	public void testGetPurchaseList() {
		Search search = new Search();
		search.setCurrentPage(2);
		search.setPageSize(5);
		
		System.out.println(((List<Purchase>)purchaseService.getPurchaseList(search, "user08").get("list")).size());
	}
	
	
	//@Test
	public void testGetPurchaseHistoryList() {
		Search search = new Search();
		search.setCurrentPage(2);
		search.setPageSize(5);
		
		System.out.println(purchaseService.getPurchaseHistoryList(search, "user08"));
	}
	
	
	//@Test
	public void testGetSaleList() {
	
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(5);
		
		purchaseService.getSaleList(search);
		
	}
	
	
	//@Test
	public void testUpdatePurchase() {
		Purchase purchase = purchaseService.getPurchase(10003);
		purchase.setReceiverName("�谩ö");
		purchase.setDlvyDate("24-09-09");
//		purchase.setDlvyDate(null);
		
		purchaseService.updatePurchase(purchase);
	}
	
	
//	@Test
	public void testUpdateTranCode() {
		Purchase purchase = purchaseService.getPurchase(10003);
		
		purchaseService.updateTranCode(purchase, "3");
		
	}
	
	
//	@Test
	public void testUpdateTranCodeByTranNo() {
		
		purchaseService.updateTranCode(10003, "4");
	}
	
	
}
// class end