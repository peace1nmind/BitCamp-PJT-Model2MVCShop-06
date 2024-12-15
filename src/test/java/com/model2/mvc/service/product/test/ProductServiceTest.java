package com.model2.mvc.service.product.test;
// W D 

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml",
										"classpath:config/context-transaction.xml" })
public class ProductServiceTest {

	// Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	@Test
	public void testGetProductList() throws Exception {
		
		System.out.println("\n==============================");
		
		Search search = new Search();
		search.setPageSize(5);
		search.setCurrentPage(3);
		
		Map<String, Object> map = productService.getProductList(search);
		List<Product> list = (List<Product>) map.get("list");
		int count = (int) map.get("count");
		
		System.out.println("\n\ncount= "+count);
		
		for (Product prod : list) {
			System.out.println((list.indexOf(prod)+1)+" 번째 상품 :"+prod);
		}
		
		System.out.println("==============================\n");
	}
	
	//@Test
	public void testGetProductListOrderBy() throws Exception {
		
		System.out.println("\n==============================");
		
		Search search = new Search();
		search.setPageSize(5);
		search.setCurrentPage(1);
		search.setOrderBy("price");
		search.setDesc(false);
		
		Map<String, Object> map = productService.getProductList(search);
		List<Product> list = (List<Product>) map.get("list");
		int count = (int) map.get("count");
		
		System.out.println("\n\ncount= "+count);
		
		for (Product prod : list) {
			System.out.println((list.indexOf(prod)+1)+" 번째 상품 :"+prod);
		}
		
		System.out.println("==============================\n");
	}
	
	//@Test
	public void testAddProduct() throws Exception {
		
		Product product = new Product();
		product.setProdName("04Test01");
		product.setManuDate("240812");
		product.setPrice(444111);
		
		product = productService.addProduct(product);
		
		System.out.println("\n==============================");
		System.out.println(product);
		System.out.println("==============================\n");
		
	}
	
	//@Test
	public void testGetProduct() throws Exception {
		
		System.out.println("\n==============================");
		System.out.println(productService.getProduct(10040));
		System.out.println("==============================\n");
	}
	
	//@Test
	public void testUpdateProduct() throws Exception {
		
		Product product = productService.getProduct(10040);
		product.setProdDetail("04리펙토링 테스트");
		
		product = productService.updateProduct(product);
		
		System.out.println("\n==============================");
		System.out.println(product);
		System.out.println("==============================\n");
	}
	
	//@Test
	public void testUpdateTranCode() throws Exception {
		
		productService.updateTranCode(10040, "2");
		Product product = productService.getProduct(10040);
		
		System.out.println("\n==============================");
		System.out.println(product);
		System.out.println("==============================\n");
	}

}
// class end