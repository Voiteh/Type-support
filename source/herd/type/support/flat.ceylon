import ceylon.language.meta.model {
	Type,
	IntersectionType,
	UnionType,
	ClassOrInterface,
	InterfaceModel
}
import ceylon.language.meta.declaration {
	ClassOrInterfaceDeclaration,
	OpenInterfaceType,
	OpenType,
	OpenClassOrInterfaceType,
	OpenTypeVariable,
	OpenUnion,
	OpenIntersection,
	nothingType
}

"Anonymous object providing posibilities for flattening hierarchy, for given type or declaration"
shared object flat{
	
	"Flattens given [[OpenType]] hierarchy into stream providing lazy evaluated chain of [[Type]]s"
	shared {OpenType*} openTypes(
		"OpenType hierarchy container to be flatten"
		OpenType type
	){
		{OpenType*} result;
		switch(type)
		case (nothingType) {
			//ignore
			result=empty;
		}
		case (is OpenClassOrInterfaceType) {
			if(exists parent=type.extendedType){
				result={type}.chain(openTypes(parent))
						.chain(type.satisfiedTypes.flatMap((OpenInterfaceType element) => openTypes(element)));
			}else{
				result={type,*type.satisfiedTypes.flatMap((OpenInterfaceType element) => openTypes(element))};
			}
		}
		case (is OpenTypeVariable) {
			result={type};
		}
		case (is OpenUnion) {
			result={*type.caseTypes.flatMap((OpenType element) => openTypes(element))};
		}
		case (is OpenIntersection) {
			result={type,*type.satisfiedTypes.flatMap((OpenType element) => openTypes(element))};
		}
		return result;
	}
	
	"Flattens given [[Type]] hierarchy into stream providing lazy evaluated chain of [[Type]]s"
	shared {Type<>*} types(
		"Type hierarchy container to be flatten"
		 Type<> type
	){
		{Type<>*} result;
		switch(type)
		case (is IntersectionType<>) {
			result={type,*type.satisfiedTypes.flatMap((Type<Anything> element) => types(element))};
		}
		else case (is UnionType<>){
			result={*type.caseTypes.flatMap((Type<Anything> element) => types(element))};
		}
		else case(is ClassOrInterface<>){
			if(exists parent=type.extendedType){
				result={type}.chain(types(parent))
						.chain(type.satisfiedTypes.flatMap((InterfaceModel<Anything> element) => types(element)));
			}else{
				result={type,*type.satisfiedTypes.flatMap((InterfaceModel<Anything> element) => types(element))};
			}
		}
		else {
			result={type};
		}
		return result.distinct;
	}
	
	"Flattens given [[ClassOrInterfaceDeclaration]] declaration hierarchy into stream, providing chain of declarations."
	shared {ClassOrInterfaceDeclaration*} declarations(
		"Declaration for which flattening happens"
		ClassOrInterfaceDeclaration declaration
	){
		{ClassOrInterfaceDeclaration*} result;
		if(exists parent=declaration.extendedType){
			result={declaration}.chain(declarations(parent.declaration))
					.chain(declaration.satisfiedTypes.flatMap((OpenInterfaceType element) => declarations(element.declaration)));
		}else{
			result={declaration,*declaration.satisfiedTypes.flatMap((OpenInterfaceType element) => declarations(element.declaration))};
		}
		return result.distinct;
	}
}