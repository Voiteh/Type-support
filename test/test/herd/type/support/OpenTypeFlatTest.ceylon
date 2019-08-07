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
		value openTypes = flat.openTypes(`interface IA`.openType);
		assert (openTypes.contains(`interface IA`.openType));
		assert (openTypes.contains(`interface I`.openType));
	}
	shared test
	void shouldContainInterfacesInClass() {
		value openTypes = flat.openTypes(`class A`.openType);
		assert (openTypes.contains(`interface IA`.openType));
		assert (openTypes.contains(`interface I`.openType));
	}
	
	shared test
	void shouldContainInterfacesFromParentClass() {
		value openTypes = flat.openTypes(`class C`.openType);
		assert (openTypes.contains(`interface IA`.openType));
		assert (openTypes.contains(`interface I`.openType));
	}
	
	shared test
	void shouldContainParentClasses() {
		value openTypes = flat.openTypes(`class C`.openType);
		assert (openTypes.contains(`class A`.openType));
		assert (openTypes.contains(`class B`.openType));
	}
}