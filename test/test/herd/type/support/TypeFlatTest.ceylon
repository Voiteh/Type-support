import ceylon.test {
	test
}
import herd.type.support {
	flat
}
import test.herd.type.support.model {
	IA,
	I,
	A,
	C,
	B,
	D,
	IC
}

shared class FlatTest() {
	
	shared test
	void shouldContainParentInInterface() {
		value types = flat.types(`IA`);
		assert (types.contains(`IA`));
		assert (types.contains(`I`));
	}
	shared test
	void shouldContainInterfacesInClass() {
		value types = flat.types(`A`);
		assert (types.contains(`IA`));
		assert (types.contains(`I`));
	}
	
	shared test
	void shouldContainInterfacesFromParentClass() {
		value types = flat.types(`C`);
		assert (types.contains(`IA`));
		assert (types.contains(`I`));
	}
	
	shared test
	void shouldContainParentClasses() {
		value types = flat.types(`C`);
		assert (types.contains(`A`));
		assert (types.contains(`B`));
	}
	shared test
	void shouldContainAllMutualParents(){
		value types=flat.types(`C|D`);
		assert(types.contains(`I`));
		assert(types.contains(`IA`));
		assert(types.contains(`A`));
		assert(types.contains(`B`));
	}
	
	shared test
	void shouldContainOnlyNothingForEmptyClassIntersection(){
		value types=flat.types(`C&D`);
		assert(types.contains(`Nothing`));
	}
	shared test
	void shouldContainOnlyMutualInterfacesForIntersection(){
		value types=flat.types(`IA&IC`);
		assert(types.contains(`IA&IC`));
		assert(types.contains(`IC`));
		assert(types.contains(`IA`));
		assert(types.contains(`I`));
		print(types);
	}
}
