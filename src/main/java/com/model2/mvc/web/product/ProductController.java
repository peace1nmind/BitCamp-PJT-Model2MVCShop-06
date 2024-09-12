package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Paging;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

// W 24.09.12.start 

@Controller
public class ProductController {

	// Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	// Constructor
	public ProductController() {
		System.out.println(":: " + getClass().getName() + " default Constructor call\n");
	}

	// Method
	@RequestMapping("/listProduct.do")
	public String listProduct(@RequestParam("menu") String menu,
							  @ModelAttribute("search") Search search,
							  @RequestParam(name = "salePage", required = false, defaultValue = "1") int salePage,
							  Model model) throws Exception {
		
		System.out.println("/listProduct.do");
		
		// 상품 목록 / 상품 관리 구분 로직
		// menu: search , manage
		model.addAttribute("menu" ,menu);
		model.addAttribute("title", (menu!=null && menu.equals("search"))? "상품 목록조회" : "상품관리");
		model.addAttribute("navi", (menu!=null && menu.equals("search"))? "getProduct.do" : "updateProductView.do");
		
		
		// 검색 조건을 다루는 로직
		search.setPageSize(pageSize);
		model.addAttribute(search);
		
		
		// 검색한 리스트값들을 다루는 로직 (list, count)
		/* 판매중인 상품들 (listProduct) */
		Map<String, Object> map = productService.getProductList(search);
		model.addAttribute("map" ,map);
		
		// 페이지를 다루는 로직
		Paging paging = new Paging((int) map.get("count"), search.getCurrentPage(), pageSize, pageUnit);
		model.addAttribute("paging" ,paging);
		
		
		/* 구매완료 상품들 (listSale) */
		if (menu.equals("manage")) {
			Search saleSearch = new Search(salePage, pageSize);
			Map<String, Object> saleMap = purchaseService.getSaleList(saleSearch);
			model.addAttribute("saleMap", saleMap);
			
			Paging salePaging = new Paging((int) saleMap.get("count"), search.getCurrentPage(), pageSize, pageUnit);
			model.addAttribute("salePaging", salePaging);
		}
		
		
		return "forward:/product/listProduct.jsp";
	}
	
	
	@RequestMapping("/getProduct")
	public String getProduct(@RequestParam("prodNo") String prodNo,
							 HttpServletRequest request,
							 HttpServletResponse response,
							 Model model) throws NumberFormatException, Exception {
		
		// 상품정보를 가져오는 로직
		model.addAttribute("product", productService.getProduct(Integer.parseInt(prodNo)));
		
		
		// 최근 본 상품 리스트 로직
		Cookie[] cookies = request.getCookies();
		Cookie history = new Cookie("history", null);
		
		if (cookies != null && cookies.length > 0) {
			for (Cookie cookie : cookies) {
				history = (cookie.getName().equals("history")) ? cookie : history;
			}
		}
		

		String historyValue = history.getValue();
		String value = "";
		
		if (historyValue == null) {
			value = prodNo;
			
		} else {
			
			if (!historyValue.contains(prodNo)) {
				value = prodNo + "&" + historyValue;
				
			} else {
				value = historyValue.replace(prodNo, "");
				
				String[] splittedValue = value.split("&");
				value = "";
				
				for (int i = 0; i < splittedValue.length; i++) {
					
					if (!(splittedValue[i]==null || splittedValue[i].equals(""))) {
						value += splittedValue[i] + ((i < splittedValue.length -1)? "&" : "");
						
					}
				}
				
				value = prodNo + "&" + value;
				
			}
	
		}
		
		history.setValue(value);
		response.addCookie(history);
		
		return "forward:/product/getProduct.jsp";
	}

}
// class end