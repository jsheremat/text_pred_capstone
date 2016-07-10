DF_pos <- function(DF) {
DF_size<-dim(DF)[1]
DF_new<-DF

vec<-as.vector(DF$firstword)
vec2<-as.vector(DF$freq)
vec2[1]<-1
  for (i in 2:DF_size) {
    
    if (vec[i-1]==vec[i]) {
      vec2[i]<-vec2[i-1]+1
    } else {
      vec2[i]<-1
    }
  }
DF_new$pos<-vec2
return (DF_new)
}
