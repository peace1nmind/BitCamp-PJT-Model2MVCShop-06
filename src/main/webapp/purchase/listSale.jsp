<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

	<head>
	
		<title>구매완료 목록</title>
	
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
		<script type="text/javascript">
			function fncGetUserList() {
				document.detailForm.submit();
			}
			
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
	
		<div style="width: 98%; margin-left: 10px;">
		
			<form name="detailForm" action="/listPurchaseHistory.do" method="post">
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
				
					<tr>
						<td colspan="11">전체 ${salePaging.total } 건수, 현재 ${salePaging.currentPage } 페이지</td>
					</tr>
					<tr>
						<td class="ct_list_b" width="50">No</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b" width="100">상품명</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b" width="100">받는사람</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">전화번호</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">구매일자</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">배송현황</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">정보수정</td>
					</tr>
					<tr>
						<td colspan="11" bgcolor="808285" height="1"></td>
					</tr>
					
					<c:forEach var="purchase" items="${saleMap.list }" varStatus="status">
						<tr class="ct_list_pop">
							<td align="center">
								${status.count }
							</td>
							
							<td></td>
							<%-- 상품명 --%>
							<td align="left">
								<a href="/getProduct.do?prodNo=${purchase.purchaseProd.prodNo }">
									${purchase.purchaseProd.prodName }
								</a>
							</td>
							
							<td></td>
							
							<%-- 받는사람 --%>
							<td align="left">
								${purchase.receiverName }
							</td>
							
							<td></td>
							
							<%-- 전화번호 --%>
							<td align="left">
								${purchase.receiverPhone }
							</td>
							
							<td></td>
							
							<%-- 구매일자 --%>
							<td align="left">
								${purchase.orderDate }
							</td>
							
							<td></td>
							
							<%-- 배송현황 --%>
							<td align="left">
								${tranCodeMap[purchase.tranCode] }
							</td>
							
							<td></td>
							
							<%-- 정보수정(배송하기) --%>
							<td align="left">
						
								<c:if test="${menu=='manage' && purchase.purchaseProd.proTranCode=='2' }">
									&nbsp;
									<a href="/updateTranCodeByProd.do?page=${salePaging.currentPage }
																	 &prodNo=${purchase.purchaseProd.prodNo }
																	 &tranCode=${purchase.purchaseProd.proTranCode }">
										배송하기
									</a>
								</c:if>
								
							</td>
						</tr>
						
					</c:forEach>
					
					
					<c:if test="${salePaging.total == 0 }">
						<tr class="ct_list_pop">
							<table>
								<tr>
									<td></td>
									<td align="center">
										<h3>배송할(구매완료 상태의) 상품이 없습니다.</h3>
									</td>
								</tr>
							</table>
						</tr>
					</c:if>

					
				</table>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
					
					<tr>
						<td align="center">

							<a href="/listProduct.do?menu=manage
													&salePage=1" 
							${(salePaging.left)? "":"class='disabled'" }>
								<span>◀</span>
							</a>
							
							&nbsp;
							
							<a href="/listProduct.do?menu=manage
													&salePage=${salePaging.start - 1 }" 
							${(salePaging.left)? "":"class='disabled'" }>
								<span>이전</span>
							</a>
					
							&nbsp;&nbsp;
							
							<c:forEach begin="${salePaging.start }" end="${salePaging.end }" varStatus="status">
							
								<a href="/listProduct.do?menu=manage
														&salePage=${status.count }" 
								${(salePaging.currentPage==status.count)? "style='font-weight: bold; font-size: 15px'" : "" }>
									${status.count }
								</a> 
								
							</c:forEach>

							&nbsp;&nbsp;
							
							<a href="/listProduct.do?menu=manage
														 &salePage=${salePaging.end + 1 }" 
							${(salePaging.right)? "":"class='disabled'" }>
								<span>다음</span>
							</a>
							
							&nbsp;
							
							<a href="/listProduct.do?menu=manage
														 &salePage=${salePaging.totalPage }" 
							${(salePaging.right)? "":"class='disabled'" }>
								<span>▶</span>
							</a>

						</td>
					</tr>
					
				</table>
			
			<!--  페이지 Navigator 끝 -->
			</form>
		
		</div>
		
		<br><br>
		
	</body>
</html>
