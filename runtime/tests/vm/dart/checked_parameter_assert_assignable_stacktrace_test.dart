// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'causal_stacks/utils.dart' show assertStack, IGNORE_REMAINING_STACK;

class A {
  void takesA(A a) {
    print("Hello A");
  }
}

class B extends A {
  void takesA(covariant B b) {
    print("Hello B");
  }
}

StackTrace? trace = null;

void main() {
  A a = new A();
  A b = new B();
  try {
    b.takesA(a);
  } catch (e, st) {
    trace = st;
  }
  assertStack(const <String>[
    r'^#0      B.takesA \(.*/checked_parameter_assert_assignable_stacktrace_test.dart:14(:27)?\)$',
    r'^#1      main \(.*/checked_parameter_assert_assignable_stacktrace_test.dart:25(:7)?\)$',
    IGNORE_REMAINING_STACK,
  ], trace!);
}
