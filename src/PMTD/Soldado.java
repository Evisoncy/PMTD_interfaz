package PMTD;

public class Soldado {
    private String nombre;
    private String telef;
    private String grado;
    private String unidad ;   

    public Soldado( String nombre,String telef, String grado, String unidad) {
        this.nombre = nombre;
        this.telef = telef;
        this.grado = grado;
        this.unidad = unidad;
    }

    public String getTelef() {
        return telef;
    }

    public void setTelef(String telef) {
        this.telef = telef;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getGrado() {
        return grado;
    }

    public void setGrado(String grado) {
        this.grado = grado;
    }

    public String getUnidad() {
        return unidad;
    }

    public void setUnidad(String unidad) {
        this.unidad = unidad;
    }

       

    public static void main (String args[]){
        
        
             
        
    }
     
}