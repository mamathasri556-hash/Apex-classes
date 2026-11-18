public class BlobToTextUtil {
    public static Integer hexToDecimal(String hexPair) {
        String digits = '0123456789ABCDEF';
        hexPair = hexPair.toUpperCase();
        Integer val = 0;
        for (Integer i = 0; i < hexPair.length(); i++) {
            Integer d = digits.indexOf(hexPair.substring(i, i+1));
            val = 16 * val + d;
        }
        return val;
    }

    public static String convertBlobToText(Blob inputBlob) {
        String hexString = EncodingUtil.convertToHex(inputBlob);
        String result = '';
        for (Integer i = 0; i < hexString.length(); i += 2) {
            String hexPair = hexString.substring(i, i+2);
            Integer decimalValue = hexToDecimal(hexPair);
            if (decimalValue >= 32 && decimalValue <= 126) {
                result += String.fromCharArray(new List<Integer>{decimalValue});
            } else {
                result += ' ';
            }
        }
        return result;
    }
}