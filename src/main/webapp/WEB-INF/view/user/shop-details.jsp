<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>${sanPham.tenSp}</title>

    <jsp:include page="./module/link-css.jsp"/>
</head>

<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Humberger Begin -->
    <jsp:include page="./module/header-mobile.jsp" >
        <jsp:param name="activePage" value="shop-grid" />
    </jsp:include>
    <!-- Humberger End -->

    <!-- Header Section Begin -->
    <jsp:include page="./module/header.jsp" >
        <jsp:param name="activePage" value="shop-grid" />
    </jsp:include>
    <!-- Header Section End -->

    <!-- Search bar Begin -->
    <jsp:include page="./module/search-bar.jsp" >
        <jsp:param name="showBanner" value="false" />
    </jsp:include>

    <!-- Breadcrumb Section Begin -->
    <!-- Breadcrumb Section End -->

    <!-- Product Details Section Begin -->
    <section class="product-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <div class="product__details__pic">
                        <div class="product__details__pic__item">
                            <img class="product__details__pic__item--large"
                                src="<c:url value = '${sanPham.hinhAnh }' />" alt="" />
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="product__details__text">
                        <h3>${sanPham.tenSp}</h3>
                        <div class="product__details__rating">
                            <c:if test="${star >= 0}">
                                <span>${star}</span>
                            </c:if>
                            <c:forEach var="s" items="${starSize}">
                                <c:if test="${s <= star}">
                                    <i class="fa fa-star"></i>
                                </c:if>
                                <c:if test="${s > star}">
                                    <i class="fa fa-star-o"></i>
                                </c:if>
                            </c:forEach>
                            <span>(${fn:length(sanPham.dsDanhGia)} đánh giá)</span>
                        </div>
                        <div class="product__details__price">${sanPham.giaSP}</div>
                        <p>
                            ${sanPham.moTa}
                        </p>
                        <div class="product__details__quantity">
                            <div class="quantity">
                                <div class="pro-qty">
                                    <input type="text" value="1" />
                                </div>
                            </div>
                        </div>
                        <a href="#" class="primary-btn">THÊM VÀO GIỎ HÀNG</a>
                        <a href="#" class="heart-icon"><span class="icon_heart_alt"></span></a>
                        <ul>
                            <li>
                                <b>Chia sẻ</b>
                                <div class="share">
                                    <a href="https://facebook.com/"><i class="fa fa-facebook"></i></a>
                                    <a href="https://twitter.com/"><i class="fa fa-twitter"></i></a>
                                    <a href="https://www.instagram.com/"><i class="fa fa-instagram"></i></a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="product__details__tab">
                        <ul class="nav nav-tabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab"
                                    aria-selected="true">Mô tả</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab"
                                    aria-selected="false">Đánh giá <span>(${fn:length(sanPham.dsDanhGia)})</span></a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="tabs-1" role="tabpanel">
                                <div class="product__details__tab__desc">
                                    <h6>Thông tin sản phẩm</h6>
                                    <p>
                                        ${sanPham.moTa}
                                    </p>
                                </div>
                            </div>
                            <div class="tab-pane" id="tabs-2" role="tabpanel">
                                <div class="product__details__tab__desc">
                                    <div class="product__details__review">
                                        <div class="review__select-star">
                                            <div class="row">
                                                <p class="col-lg-6 col-12" >Bạn cảm thấy sản phẩm này như thế nào? (chọn sao nhé):</p>
                                                <ul class="col-lg-6 col-12 ul-star">
                                                    <li data-val="1">
                                                        <i class="fa fa-star active"></i>
                                                    </li>
                                                    <li data-val="2">
                                                        <i class="fa fa-star active"></i>
                                                    </li>
                                                    <li data-val="3">
                                                        <i class="fa fa-star active"></i>
                                                    </li>
                                                    <li data-val="4">
                                                        <i class="fa fa-star active"></i>
                                                    </li>
                                                    <li data-val="5">
                                                        <i class="fa fa-star active"></i>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="review__comment">
                                            <div class="row">
                                                <div class="review__textarea col-lg-12 col-12">
                                                    <textarea 
                                                        path="noiDung"
                                                        class="review__textarea-context" 
                                                        name="reviewContent" 
                                                        placeholder="Mời bạn chia sẻ thêm một số cảm nhận về sản phẩm ..." ></textarea>
                                                </div>
                                                <a class="review__btn-submit" onclick="submitDanhGia();" >Gửi đánh giá ngay</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="product__details__comments">
                                        <c:forEach var="danhGia" items="${sanPham.dsDanhGia}">
                                            <div class="product__details__comment-item">
                                                <div class="comment__user-info">
                                                    <img 
                                                        src="<c:url value = '${danhGia.nguoiDung.hinhAnh}' />" 
                                                        alt="avatar" />
                                                    <span class="comment__user-info__name">${danhGia.nguoiDung.tenND}</span>
                                                </div>
                                                <div class="comment__rating">
                                                    <span>${danhGia.xepHang}</span>
                                                    <c:forEach var="s" items="${starSize}">
                                                        <c:if test="${s <= danhGia.xepHang}">
                                                            <i class="fa fa-star"></i>
                                                        </c:if>
                                                        <c:if test="${s > danhGia.xepHang}">
                                                            <i class="fa fa-star-o"></i>
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                                <div class="comment__content">${danhGia.noiDung}</div>
                                                <div class="comment__time">${danhGia.thoiGian}</div>
                                                <hr />
                                            </div>
                                        </c:forEach>
                                    </div>    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Product Details Section End -->

    <!-- Related Product Section Begin -->
    <section class="related-product">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title related__product__title">
                        <h2>Sản phẩm liên quan</h2>
                    </div>
                </div>
            </div>
            <div class="row">
            	<c:forEach var="sanPham" items="${dsSanPhamLQ}" begin="0" end="5">
	                <div class="col-lg-3 col-md-4 col-sm-6">
	                    <div class="product__item"
	                    	onclick=window.location.href='<c:url value = "/san-pham/id=${sanPham.maSp}" />'
	                    >
	                        <div class="product__item__pic set-bg"
	                            data-setbg="<c:url value = '${sanPham.hinhAnh}' />">
	                        </div>
	                        <div class="product__item__text">
	                            <h6><a href="<c:url value = "/san-pham/id=${sanPham.maSp}" />">${sanPham.tenSp}</a></h6>
	                            <h5>${sanPham.giaSP}</h5>
	                        </div>
	                    </div>
	                </div>
                </c:forEach>
            </div>
        </div>
    </section>
    <!-- Related Product Section End -->

    <!-- Footer Section Begin -->
    <jsp:include page="./module/footer.jsp" />
    <!-- Footer Section End -->

    <!-- Js Plugins -->
    <jsp:include page="./module/link-js.jsp"/>

    <script language="javascript">
        function submitDanhGia(){
            var xepHang = $('ul.ul-star li i.active').length;
            var noiDung = $('textarea[name="reviewContent"]').val();
            $.ajax({
                url : "<c:url value = '/san-pham/id=${sanPham.maSp}' />",
                type : "post",
                dataType: "json",
                data : {
                    maDanhGia : 0,
                    sanPham : { maSp: "${sanPham.maSp}"},
                    nguoiDung : { maND: 1},
                    noiDung : $("textarea[name='reviewContent']").val(),
                    xepHang : $(".ul-star li.active").attr("data-val")
                },
                success : function (result){
                    alert('Đánh giá thành công');
                },
                error : function (result){
                    alert('Đánh giá thất bại');
                }
            });
        }
    </script>
</body>

</html>