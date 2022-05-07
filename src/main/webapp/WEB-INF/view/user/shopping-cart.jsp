<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Giỏ Hàng</title>

    <jsp:include page="./module/link-css.jsp"/>
</head>

<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Humberger Begin -->
    <jsp:include page="./module/header-mobile.jsp" >
    	<jsp:param name="activePage" value="shopping-cart" />
    </jsp:include>
    <!-- Humberger End -->

    <!-- Header Section Begin -->
    <jsp:include page="./module/header.jsp" >
    	<jsp:param name="activePage" value="shopping-cart" />
    </jsp:include>
    <!-- Header Section End -->

    <!-- Search bar Begin -->
    <jsp:include page="./module/search-bar.jsp" >
        <jsp:param name="showBanner" value="false" />
    </jsp:include>
    
    <!-- Breadcrumb Section Begin -->
    <!-- Breadcrumb Section End -->

    <!-- Shoping Cart Section Begin -->
    <section class="shoping-cart spad">
        <div class="container">
            <div class="row shoping__cart-desktop">
                <div class="col-lg-12">
                    <div class="shoping__cart__table">
                        <table>
                            <thead>
                                <tr>
                                    <th class="shoping__product">Sản phẩm</th>
                                    <th>Giá</th>
                                    <th>Số lượng</th>
                                    <th>Tổng tiền</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="sanPham" items="${dsSanPham}">
	                                <tr>
                                        <td class="shoping__cart__item">
	                                        <img src="<c:url value = '${sanPham.hinhAnh}' />" alt="">
	                                        <h5>${sanPham.tenSp}</h5>
	                                    </td>
	                                    <td class="shoping__cart__price">
	                                        ${sanPham.giaSP}
	                                    </td>
	                                    <td class="shoping__cart__quantity">
	                                        <div class="quantity">
	                                            <div class="pro-qty">
	                                                <input type="text" value="2">
	                                            </div>
	                                        </div>
	                                    </td>
	                                    <td class="shoping__cart__total">
	                                        110.000đ
	                                    </td>
	                                    <td class="shoping__cart__item__close">
	                                        <span class="icon_close"></span>
	                                    </td>
	                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row shoping__cart-mobile">
                <c:forEach var="sanPham" items="${dsSanPham}" varStatus="status">
                    <div class="col-lg-12">
                        <div class="shoping__cart-mobile__item">
                            <img src="<c:url value = '${sanPham.hinhAnh}' />" alt="">
                            <div class="cart__item__info">
                                <a class="cart__item__name" href="<c:url value = '/san-pham/id=${sanPham.maSp}' />">
                                    ${sanPham.tenSp}
                                </a>
                                <span class="shoping__cart__price">${sanPham.giaSP}</span>
                                <span class="shoping__cart__unit">/ chiếc</span>
                                <div class="shoping__cart__quantity">
                                    <div class="quantity">
                                        <div class="pro-qty">
                                            <input type="text" value="2">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="shoping__cart__right">
                                <div class="shoping__cart__total">
                                    ${sanPham.giaSP}
                                </div>
                                <a class="shoping__cart__btn-delete" href="#">Xóa</a>
                            </div>
                            <c:if test="${status.last}">
                                <hr/>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="shoping__cart__btns">
                        <a href="<c:url value = '/san-pham' />" class="primary-btn cart-btn">TIẾP TỤC MUA SẮM</a>
                        <a href="" class="primary-btn cart-btn cart-btn-right">
                            <span class="icon_loading"></span>
                            CẬP NHẬT GIỎ HÀNG
                        </a>
                    </div>
                </div>
                <div class="col-lg-6 offset-lg-6">
                    <div class="shoping__checkout">
                        <h5>Tổng số giỏ hàng</h5>
                        <ul>
                            <li>Thành Tiền <span>218.000đ</span></li>
                            <li>Total <span>218.000đ</span></li>
                        </ul>
                        <a href="#" class="primary-btn">TIẾN HÀNH KIỂM TRA</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shoping Cart Section End -->

    <!-- Footer Section Begin -->
    <jsp:include page="./module/footer.jsp" />
    <!-- Footer Section End -->

    <jsp:include page="./module/link-js.jsp"/>

</body>

</html>