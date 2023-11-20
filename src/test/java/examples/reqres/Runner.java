package examples.reqres;

import com.intuit.karate.junit5.Karate;

class Runner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("single_resource").tags().relativeTo(getClass());}

}
