import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/domain/auth_state.dart';
import '../features/auth/presentation/controllers/auth_controller.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/splash_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/sales/presentation/offline_sale_screen.dart';
import '../features/sales/presentation/online_sale_screen.dart';
import '../features/sales/presentation/offline_queue_screen.dart';
import '../features/branches/presentation/branch_list_screen.dart';
import '../features/branches/presentation/branch_reports_screen.dart';
import '../features/inventory/presentation/inventory_screen.dart';
import '../features/orders/presentation/orders_screen.dart';
import '../features/suppliers/presentation/supplier_list_screen.dart';
import '../features/batches/presentation/batch_timer_screen.dart';
import '../features/tables/presentation/table_map_screen.dart';
import '../features/shipping/presentation/shipping_screen.dart';
import '../features/catalog/presentation/product_list_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/sales/offline',
        name: 'sales_offline',
        builder: (context, state) => const OfflineSaleScreen(),
      ),
      GoRoute(
        path: '/sales/offline/queue',
        name: 'sales_offline_queue',
        builder: (context, state) => const OfflineQueueScreen(),
      ),
      GoRoute(
        path: '/sales/online',
        name: 'sales_online',
        builder: (context, state) => const OnlineSaleScreen(),
      ),
      GoRoute(
        path: '/branches',
        name: 'branches',
        builder: (context, state) => const BranchListScreen(),
      ),
      GoRoute(
        path: '/reports',
        name: 'reports',
        builder: (context, state) => const BranchReportsScreen(),
      ),
      GoRoute(
        path: '/inventory',
        name: 'inventory',
        builder: (context, state) => const InventoryScreen(),
      ),
      GoRoute(
        path: '/orders',
        name: 'orders',
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: '/suppliers',
        name: 'suppliers',
        builder: (context, state) => const SupplierListScreen(),
      ),
      GoRoute(
        path: '/batches',
        name: 'batches',
        builder: (context, state) => const BatchTimerScreen(),
      ),
      GoRoute(
        path: '/tables',
        name: 'tables',
        builder: (context, state) => const TableMapScreen(),
      ),
      GoRoute(
        path: '/shipping',
        name: 'shipping',
        builder: (context, state) => const ShippingScreen(),
      ),
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) => const ProductListScreen(),
      ),
    ],
    redirect: (context, state) {
      final status = authState.status;
      final loggingIn = state.uri.path == '/login';
      if (status == AuthStatus.unknown) {
        return state.uri.path == '/' ? null : '/';
      }
      if (status == AuthStatus.unauthenticated && !loggingIn) {
        return '/login';
      }
      if (status == AuthStatus.authenticated &&
          (loggingIn || state.uri.path == '/')) {
        return '/dashboard';
      }
      return null;
    },
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(child: Text('Ruta no encontrada: ${state.uri}')),
      );
    },
  );
});
