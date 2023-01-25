void setup() {
  Serial.begin(115200);

  Serial.println("----- Begin -----");
  int a = 1;
  int b = 1;
  int c = 1;
  int d = 1;
  int e = 1;
  int f = 1;
  
  while (a == b && b == c && c == d && d == e && e == f) 
  {
    for(long i = 1; i < 1000000; i++){a = (a + i);} 
    for(long j = 1; j < 1000000; j++){b = (b + j);} 
    for(long k = 1; k < 1000000; k++){c = (c + k);} 
    for(long l = 1; l < 1000000; l++){d = (d + l);} 
    for(long m = 1; m < 1000000; m++){e = (e + m);} 
    for(long n = 1; n < 1000000; n++){f = (f + n);} 
    
    Serial.println("X");
  }

  // Unreachable code
  Serial.println("################################# Glitch! #################################");
}

// the loop routine runs over and over again forever:
void loop() 
{

}
