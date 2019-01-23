shared interface Other {}
shared interface I {}
shared interface IA satisfies I {}
shared interface IC {}
shared class A() satisfies IA {}

shared class B() extends A()  {}

shared class C() extends B() satisfies IC & Other {}


shared class D() satisfies IA{}
