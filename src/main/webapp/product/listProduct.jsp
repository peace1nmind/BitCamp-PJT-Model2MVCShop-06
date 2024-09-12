<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<!DOCTYPE html>

<html>

	<head>
	
		<title>${title }</title>
		
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
		
		<script type="text/javascript">
		<!--
		function fncGetProductList(){
			document.detailForm.submit();
		}
		-->
		
		</script>
		
		<style>
	        a.disabled {
	            pointer-events: none; /* 링크 클릭 비활성화 */
	            color: #FFFFFF; /* 비활성화 된 링크의 색상 변경 */
	            text-decoration: none; /* 링크 밑줄 제거 */
	            cursor: default; /* 기본 커서로 변경 */
	        }
	        
    	</style>
		
	</head>

	<body bgcolor="#ffffff" text="#000000">
	
		<div style="width:98%; margin-left:10px;">
		
			<form name="detailForm" action="/listProduct.do?menu=${menu }" method="post">
			
				<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
					<tr>
						<td width="15" height="37">
							<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
						</td>
						<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="93%" class="ct_ttl01">
									
											${title }
									
									</td>
								</tr>
							</table>
						</td>
						<td width="12" height="37">
							<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
						</td>
					</tr>
				</table>
				
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
					<tr>
						<td align="right">
							<select name="searchCondition" class="ct_input_g" style="width:80px">
								
								<option value="0" ${(!empty search.searchCondition && search.searchCondition=='0')? "selected":"" }>
									상품번호
								</option>
								<option value="1" ${(!empty search.searchCondition && search.searchCondition=='1')? "selected":"" }>
									상품명
								</option>
								<option value="2" ${(!empty search.searchCondition && search.searchCondition=='2')? "selected":"" }>
									상품가격
								</option>
								
							</select>
							
							<input type="text" name="searchKeyword" value="${search.searchKeyword }" 
									class="ct_input_g" style="width:200px; height:19px" />
							
						</td>
						
						<td align="right" width="70">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="17" height="23">
										<img src="/images/ct_btnbg01.gif" width="17" height="23">
									</td>
									<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
										<a href="javascript:fncGetProductList();">검색</a>
									</td>
									<td width="14" height="23">
										<img src="/images/ct_btnbg03.gif" width="14" height="23">
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
					<tr>
						<td colspan="11" >전체 ${paging.total } 건수, 현재 ${paging.currentPage } 페이지</td>
					</tr>
					<tr>
						<td class="ct_list_b" width="100">No</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b" width="150">상품명</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b" width="150">
							가격&nbsp;
							<input type="button" value="↑↓" 
									onclick="window.location.href='/listProduct.do?page=1&menu=${menu }&searchCondition=${search.searchCondition }&searchKeyword=${search.searchKeyword }&orderBy=price&desc=${!search.desc }'">
						</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">등록일</td>	
						<td class="ct_line02"></td>
						<td class="ct_list_b">현재상태</td>	
					</tr>
					<tr>
						<td colspan="11" bgcolor="808285" height="1"></td>
					</tr>
					
					<c:forEach items="${map.list }" var="product" varStatus="status">
					
						<tr class="ct_list_pop">
							<td align="center">${status.count }</td>
							<td></td>
									
							<td align="left">
								<a href="/${navi }?prodNo=${product.prodNo }">
									${product.prodName }
								</a>
							</td>
							
							<td></td>
							<td align="left">${product.price }</td>
							<td></td>
							<td align="left">${product.regDate }</td>
							<td></td>
							
							<td align="left">
								${tranCodeMap[product.proTranCode] }
							</td>	
						</tr>
						<tr>
							<td colspan="11" bgcolor="D6D7D6" height="1"></td>
						</tr>	
						
					</c:forEach>
					
				</table>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
					<tr>
						<td align="center">
					
							<a href="/listProduct.do?page=1
													&menu=${menu }
													&searchCondition=${search.searchCondition }
													&searchKeyword=${search.searchKeyword }
													&orderBy=${search.orderBy }
													&desc=${search.desc}" 
							${(paging.left)? "":"class='disabled'" }>
								<span>◀</span>
							</a>
							
							&nbsp;
							
							<a href="/listProduct.do?page=${paging.start - 1 }
													&menu=${menu }
													&searchCondition=${search.searchCondition }
													&searchKeyword=${search.searchKeyword }
													&orderBy=${search.orderBy }
													&desc=${search.desc}" 
							${(paging.left)? "":"class='disabled'" }>
								<span>이전</span>
							</a>
							
							&nbsp;&nbsp;
							
					<c:forEach begin="${paging.start }" end="${paging.end }" var="i" >
							<a href="/listProduct.do?page=${i }
													&menu=${menu }
													&searchCondition=${search.searchCondition }
													&searchKeyword=${search.searchKeyword }
													&orderBy=${search.orderBy }
													&desc=${search.desc}" 
							${(paging.currentPage==i)? "style='font-weight: bold; font-size: 15px'" : "" }>
								${i }
							</a>
					</c:forEach>
					
							&nbsp;&nbsp;
						
							
							<a href="/listProduct.do?page=${paging.end + 1 }
													&menu=${menu }
													&searchCondition=${search.searchCondition }
													&searchKeyword=${search.searchKeyword }
													&orderBy=${search.orderBy }
													&desc=${search.desc}" 
							${(paging.right)? "":"class='disabled'" }>
								<span>다음</span>
							</a>
							
							&nbsp;
							
							<a href="/listProduct.do?page=${paging.totalPage }
													&menu=${menu }
													&searchCondition=${search.searchCondition }
													&searchKeyword=${search.searchKeyword }
													&orderBy=${search.orderBy }
													&desc=${search.desc}" 
							${(paging.right)? "":"class='disabled'" }>
								<span>▶</span>
							</a>
							

				    	</td>
					</tr>
				</table>
				<!--  페이지 Navigator 끝 -->
			
			</form>
		
		</div>
		
		<br><br>
		
		<c:if test="${menu=='manage' }">
			<%	System.out.println("\tinclude 발생: listSale.jsp"); %>
			<%--<jsp:include page="/purchase/listSale.jsp"></jsp:include>--%>
			<%@ include file="../purchase/listSale.jsp" %>
		</c:if>
	</body>
</html>
