import ceylon.language.meta.model {
	Type,
	ClassModel,
	ClassOrInterface,
	InterfaceModel,
	UnionType,
	IntersectionType
}
import ceylon.language.meta.declaration {
	ClassOrInterfaceDeclaration,
	ClassDeclaration
}
shared interface TypeHierarchy of ClassOrInterfaceHierarchy | UnionTypeHierarchy | IntersectionTypeHierarchy {}
shared interface IntersectionTypeHierarchy satisfies TypeHierarchy {
	
	shared formal TypeHierarchy[] satisfiedTypeHierarchies;
}
shared interface UnionTypeHierarchy satisfies TypeHierarchy {
	
	shared formal TypeHierarchy[] caseTypeHierarchies;
	
}
shared interface ClassOrInterfaceHierarchy satisfies TypeHierarchy {
	shared formal ClassOrInterface<>? findByDeclaration(ClassOrInterfaceDeclaration declaration);
	shared formal ClassModel<>[] superTypes;
	shared formal InterfaceModel<>[] interfaces;
	shared formal TypeHierarchy[] parameterHierarchies;
}


{ClassModel<>*} extractSuperTypes(ClassOrInterface<> model) {
	if (exists extendendType = model.extendedType) {
		return { extendendType, *extractSuperTypes(extendendType) };
	}
	return empty;
}
{InterfaceModel<>*} extractInterfaces(ClassOrInterface<> model) {
	if (is InterfaceModel<> model) {
		return { model, *model.satisfiedTypes.flatMap((InterfaceModel<> element) => extractInterfaces(element)) };
	} else {
		return model.satisfiedTypes.flatMap((InterfaceModel<> element) => extractInterfaces(element));
	}
}
shared TypeHierarchy typeHierarchy(Type<> type){
	switch(type)
	case (is ClassOrInterface<>) {
		return classOrInterfaceHierarchy(type);
	}
	else case (is UnionType<>){
		return unionTypeHierarchy(type);
	}
	else case (is IntersectionType<>){
		return intersectionTypeHierarchy(type);
	}
	else {throw Exception("Unparsable type hierarchy ``type``");}
}
shared IntersectionTypeHierarchy intersectionTypeHierarchy(IntersectionType<> intersectionType)=> object satisfies IntersectionTypeHierarchy{
	shared actual TypeHierarchy[] satisfiedTypeHierarchies= intersectionType.satisfiedTypes.map((Type<Anything> element) => typeHierarchy(element)).sequence();
};
shared UnionTypeHierarchy unionTypeHierarchy(UnionType<> unionType) => object satisfies UnionTypeHierarchy{
	shared actual TypeHierarchy[] caseTypeHierarchies => unionType.caseTypes.map((Type<Anything> element) => typeHierarchy(element)).sequence();	
};
shared ClassOrInterfaceHierarchy classOrInterfaceHierarchy(ClassOrInterface<> classOrInterface) => object satisfies ClassOrInterfaceHierarchy{
	shared actual InterfaceModel<Anything>[] interfaces = extractInterfaces(classOrInterface).sequence();
	
	shared actual ClassModel<Anything,Nothing>[] superTypes = extractSuperTypes(classOrInterface).sequence();
	
	shared actual ClassOrInterface<Anything>? findByDeclaration(ClassOrInterfaceDeclaration declaration) {

			if(classOrInterface.declaration==declaration){
				return classOrInterface;
			}else if(is ClassDeclaration declaration){
				return superTypes.find((ClassModel<Anything,Nothing> element) => element.declaration==declaration);
			}else{
				return interfaces.find((InterfaceModel<Anything> element) => element.declaration==declaration);
			}

	}
	shared actual TypeHierarchy[] parameterHierarchies =classOrInterface.typeArgumentList.map((Type<Anything> element) => typeHierarchy(element)).sequence();

	
	
	
	
	
};


