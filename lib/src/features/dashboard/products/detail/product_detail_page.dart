import 'package:cached_network_image/cached_network_image.dart';
import 'package:entrance_test/src/constants/color.dart';
import 'package:entrance_test/src/constants/icon.dart';
import 'package:entrance_test/src/constants/image.dart';
import 'package:entrance_test/src/features/dashboard/products/detail/component/product_detail_controller.dart';
import 'package:entrance_test/src/utils/date_util.dart';
import 'package:entrance_test/src/utils/number_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray100,
      appBar: AppBar(
        title: const Text(
          "Product Detail",
          style: TextStyle(
            fontSize: 16,
            color: gray900,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: white,
        elevation: 0,
      ),
      body: Obx(
        () => (controller.isLoadingRetrieveProduct)
            ? const Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primary),
              ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Container(
                        decoration: const BoxDecoration(color: white),
                        child: CachedNetworkImage(
                          imageUrl:
                              controller.product.images?.isNotEmpty == true
                                  ? controller.product.images![0].urlSmall ?? ''
                                  : '',
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Image.asset(
                            ic_error_image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      decoration: const BoxDecoration(color: white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.product.name ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              color: gray900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (controller.product.priceAfterDiscount !=
                              controller.product.price)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  controller.product.price.inRupiah(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: gray600,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  controller.product.priceAfterDiscount
                                      .inRupiah(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: red600,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                          else
                            Text(
                              controller.product.price.inRupiah(),
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 18,
                                color: gray900,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rate_rounded,
                                color: yellow,
                              ),
                              const SizedBox(width: 4),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${controller.product.ratingAverage}',
                                      style: const TextStyle(color: gray900),
                                    ),
                                    TextSpan(
                                      text:
                                          ' (${controller.product.reviewCount} Reviews)',
                                      style: const TextStyle(
                                        color: gray600,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Product Description',
                            style: TextStyle(
                              fontSize: 16,
                              color: gray900,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            controller.product.description ?? 'No Description',
                            style: const TextStyle(
                              fontSize: 12,
                              color: gray900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Terms & Conditions of Return / Refund',
                            style: TextStyle(
                              fontSize: 16,
                              color: gray900,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: List.generate(
                              (controller.product.refundTermsAndCondition ?? '')
                                  .split('\n')
                                  .length,
                              (index) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${index + 1}. ',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: gray900,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      (controller.product
                                                  .refundTermsAndCondition ??
                                              '')
                                          .split('\n')[index],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: gray900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    controller.ratings.isNotEmpty
                        ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: const BoxDecoration(
                              color: white,
                            ),
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Product Review',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: gray900,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Text(
                                      'See More',
                                      style: TextStyle(
                                        color: primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rate_rounded,
                                      color: yellow,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      controller.product.ratingAverage ?? '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: gray900,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'from ${controller.product.ratingCount} rating',
                                      style: const TextStyle(
                                        color: gray600,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Container(
                                      width: 4,
                                      height: 4,
                                      decoration: const BoxDecoration(
                                        color: gray500,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${controller.product.reviewCount} reviews',
                                      style: const TextStyle(
                                        color: gray600,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                ...List.generate(
                                  controller.ratings.length > 3
                                      ? 3
                                      : controller.ratings.length,
                                  (index) => Container(
                                    margin: EdgeInsets.only(
                                      bottom:
                                          index + 1 != controller.ratings.length
                                              ? 24
                                              : 0,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipOval(
                                              child: CachedNetworkImage(
                                                width: 40,
                                                height: 40,
                                                imageUrl: controller
                                                        .ratings[index]
                                                        .user
                                                        ?.profilePicture ??
                                                    '',
                                                fit: BoxFit.cover,
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                  width: 48,
                                                  height: 48,
                                                  defaultProfileImage,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller.ratings[index]
                                                            .user?.name ??
                                                        '',
                                                    style: const TextStyle(
                                                      color: gray900,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: List.generate(
                                                      5,
                                                      (index) => Icon(
                                                        Icons.star_rate_rounded,
                                                        color: index <
                                                                (controller
                                                                        .ratings[
                                                                            index]
                                                                        .rating ??
                                                                    0)
                                                            ? yellow
                                                            : gray200,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              DateUtil.getTimeAgo(controller
                                                      .ratings[index]
                                                      .createdAt ??
                                                  DateTime.now()),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: gray600,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          controller.ratings[index].review ??
                                              '',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: gray900,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
      ),
    );
  }
}
