import test.herd.type.support.model {

	I,
	B,
	IA,
	A,
	C
}
import herd.type.support {

	flat
}
import ceylon.test {

	test
}
shared class OpenTypeFlatTest() {
	shared test
	void shouldContainParentInInterface() {
		value declarations = flat.openTypes(`interface IA`.openType);
		assert (declarations.contains(`interface IA`.openType));
		assert (declarations.contains(`interface I`.openType));
	}
	shared test
	void shouldContainInterfacesInClass() {
		value declarations = flat.openTypes(`class A`.openType);
		assert (declarations.contains(`interface IA`.openType));
		assert (declarations.contains(`interface I`.openType));
	}
	
	shared test
	void shouldContainInterfacesFromParentClass() {
		value declarations = flat.openTypes(`class C`.openType);
		assert (declarations.contains(`interface IA`.openType));
		assert (declarations.contains(`interface I`.openType));
	}
	
	shared test
	void shouldContainParentClasses() {
		value declarations = flat.openTypes(`class C`.openType);
		assert (declarations.contains(`class A`.openType));
		assert (declarations.contains(`class B`.openType));
	}
}