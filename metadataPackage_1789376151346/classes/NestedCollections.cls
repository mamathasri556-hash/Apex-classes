/**
 * @description using the map tring in one string store the detalis in list
 */
public class NestedCollections {
    public static List<String>collectionOfDetails(){
        Map<String,List<String>>details = new Map<String,List<String>>();
            details.put('mamatha',new List<String>{'pamarthiMamathasri','Btech'});
            details.put('anitha',new List<String>{'sheruAnitha','btech'});
        return details.get('mamatha');
    }
    
}