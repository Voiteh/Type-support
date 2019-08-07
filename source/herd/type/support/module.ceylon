"This module is toolbox for operating on types and it's declarations. It should simplify required operations. 
 
 - Use [[flat]] object to extract type or declaration hierarchy into stream so it can be searched or filtered. 

 		value stringflatHierarchy = flat.types(`String`);
 		assert(stringflatHierarchy.containsEvery([`SearchableList<Character>`,`List<Character>`,`Comparable<String>`,`Object`]));

 		value stringflatHierarchy = flat.declarations(`class String`);
 		assert(stringflatHierarchy.containsEvery([`interface SearchableList`,`interface List`,`interface Comparable`,`class Object`]));
"
license ("http://www.apache.org/licenses/LICENSE-2.0.html")
by("Wojciech Potiopa")
module herd.type.support "0.2.0" {}
