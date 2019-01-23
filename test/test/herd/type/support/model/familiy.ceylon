shared interface Other {}
shared interface I {}
shared interface IA satisfies I {}
shared interface IB satisfies I {}
shared interface IC satisfies I {}
shared class A() satisfies IA & Other {}

shared class B() extends A() satisfies IB & Other {}

shared class C() extends B() satisfies IC & Other {}
