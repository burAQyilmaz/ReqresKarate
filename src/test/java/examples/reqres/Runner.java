package examples.reqres;

import com.intuit.karate.junit5.Karate;

class Runner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("createPostPutPatchDelete").tags().relativeTo(getClass());}

}
