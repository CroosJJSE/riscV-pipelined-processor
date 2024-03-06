
module top_tb ();
    logic clk,reset;
  
    top top1(.*);
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    //test
    initial begin
        reset = 1;
        #1;
        reset = 0;
        repeat(10) begin   
        //$display("5.wire_im_gen: %d",top1.wire_im_gen);
       
        #20; 
         
        end
          $finish(); 
    end
    
endmodule