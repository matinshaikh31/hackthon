import 'dart:async';
import 'package:clothing/views/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'error_page.dart';
import 'methods.dart';

final routeHistory = [Routes.home];

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: Routes.home,
  routes: _routes,
  redirect: redirector,
  errorBuilder: (context, state) => const ErrorPage(),
);
FutureOr<String?> redirector(BuildContext context, GoRouterState state) {
  routeHistory.add(state.uri.path);
  if (isLoggedIn() && state.fullPath == Routes.auth) {
    // return routeHistory.reversed.elementAt(1);
    return Routes.account;
    // return Routes.home;
  }
  return null;
}

List<RouteBase> get _routes {
  return <RouteBase>[
    GoRoute(
      path: Routes.home,
      pageBuilder:
          (BuildContext context, GoRouterState state) =>
          // const NoTransitionPage(child: NewHomePage()),
          const NoTransitionPage(child: Homepage()),
      // const NoTransitionPage(child: Wrapper(body: Homepage())),
    ),

    // GoRoute(
    //   path: Routes.auth,
    //   pageBuilder:
    //       (BuildContext context, GoRouterState state) => NoTransitionPage(
    //         child: AuthPage(
    //           goTo: state.extra != null ? state.extra as String : null,
    //         ),
    //       ),
    //   // LoginPage()),
    // ),
    // GoRoute(
    //   path: Routes.account,
    //   pageBuilder:
    //       (BuildContext context, GoRouterState state) => const NoTransitionPage(
    //         child: Account(),
    //         // AuthPage(
    //         //     goTo: state.extra != null ? state.extra as String : null)
    //       ),
    // ),
  ];
}

class Routes {
  static const home = "/";
  static const category = "/category";
  static const auth = "/auth";
  static const account = "/account";
  static const contact = "/contact";
  static const privacy = "/privacy";
  static const cart = "/cart";
  static const product = "/product";
  static const checkout = "/checkout";
  static const checkoutshipping = "/checkoutshipping";
  static const checkoutpayment = "/checkoutpayment";
  static const orders = "/orders";
  static const about = "/about";
  static const faqs = "/faqs";
  static const terms = "/terms";
  static const search = "/search";
  static const returnandrefundPolicy = "/return&refund-policy";
  static const refundPolicy = "/refundfund-policy";
  static const shippingPolicy = "/shipping-policy";
  static const signup = "/signup";
  static const allproducts = "/allproducts";
  static const thankyouPage = "/thankyou";

  static go() {}
}
