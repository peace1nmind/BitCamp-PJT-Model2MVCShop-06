<%-- 구매완료목록 화면 --%>
<%-- listPurchaseHistory.do --%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>

<html>

	<head>
	
		<title>배송완료목록 조회</title>
	
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
						<td colspan="11">전체 ${historyMap.count } 건수, 현재 ${historyPaging.currentPage } 페이지</td>
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
					
					<c:forEach var="purchase" items="${historyMap.list }" varStatus="status">
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
							
							<%-- 정보수정(구매확정) --%>
							<td align="left">
							
								<c:if test="${purchase.tranCode=='4' }">
									<a href="/updateTranCode.do?tranNo=${purchase.tranNo }
																&tranCode=4
																&page=${historyPaging.currentPage }">
										구매확정
									</a>
								</c:if>
								
							</td>
						</tr>
						
					</c:forEach>
					
					
					<c:if test="${historyPaging.total == 0 }">
						<tr class="ct_list_pop">
							<table>
								<tr>
									<td></td>
									<td align="center">
										<h3>배송완료 이력이 없습니다.</h3>
									</td>
								</tr>
							</table>
						</tr>
					</c:if>

					
				</table>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
					
					<tr>
						<td align="center">

							<a href="/listPurchase.do?historyPage=1" 
							${(historyPaging.left)? "":"class='disabled'" }>
								<span>◀</span>
							</a>
							
							&nbsp;
							
							<a href="/listPurchase.do?historyPage=${historyPaging.start - 1 }" 
							${(historyPaging.left)? "":"class='disabled'" }>
								<span>이전</span>
							</a>
					
							&nbsp;&nbsp;
							
							<c:forEach begin="${historyPaging.start }" end="${historyPaging.end }" varStatus="status">
							
								<a href="/listPurchase.do?historyPage=${status.count }" 
								${(historyPaging.currentPage==status.count)? "style='font-weight: bold; font-size: 15px'" : "" }>
									${status.count }
								</a> 
								
							</c:forEach>

							&nbsp;&nbsp;
							
							<a href="/listPurchase.do?historyPage=${historyPaging.end + 1 }" 
							${(historyPaging.right)? "":"class='disabled'" }>
								<span>다음</span>
							</a>
							
							&nbsp;
							
							<a href="/listPurchase.do?historyPage=${historyPaing.totalPage }" 
							${(historyPaging.right)? "":"class='disabled'" }>
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
