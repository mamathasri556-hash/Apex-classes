/*public class PdfTextExtraction {
    public static String parse(Blob fileBlob) { 
       if(fileBlob == null){
        return 'No file found';
       } 
       try{
        String extractedText = fileBlob.toString();
        return extractedText;
       }catch(Exception e){
        return 'Error: ' + e.getMessage();
       }
  }
}*/  
public class Pdfparser {

    public static String parse(Blob pdfBlob){
        String pdfText = pdfBlob.toString();
        return pdfText;
    } 
}