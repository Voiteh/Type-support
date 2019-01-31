import test.herd.type.support.model {
	I,
	B,
	D,
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
shared class DeclarationFlatTest() {
	
	
	
	shared test
	void shouldContainParentInInterface() {
		value declarations = flat.declarations(`interface IA`);
		assert (declarations.contains(`interface IA`));
		assert (declarations.contains(`interface I`));
	}
	shared test
	void shouldContainInterfacesInClass() {
		value declarations = flat.declarations(`class A`);
		assert (declarations.contains(`interface IA`));
		assert (declarations.contains(`interface I`));
	}
	
	shared test
	void shouldContainInterfacesFromParentClass() {
		value declarations = flat.declarations(`class C`);
		assert (declarations.contains(`interface IA`));
		assert (declarations.contains(`interface I`));
	}
	
	shared test
	void shouldContainParentClasses() {
		value declarations = flat.declarations(`class C`);
		assert (declarations.contains(`class A`));
		assert (declarations.contains(`class B`));
	}
		
	
}