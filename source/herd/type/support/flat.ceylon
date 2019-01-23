import ceylon.language.meta.model {
	Type,
	IntersectionType,
	UnionType,
	ClassOrInterface,
	InterfaceModel
}
import ceylon.language.meta.declaration {
	ClassOrInterfaceDeclaration,
	OpenInterfaceType
}
shared object flat{
	shared {Type<>*} types(Type<> type){
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
	
	shared {ClassOrInterfaceDeclaration*} declarations(ClassOrInterfaceDeclaration declaration){
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