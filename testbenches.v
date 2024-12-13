module tb_ShiftRotate;

    reg [31:0] data_in;
    reg [4:0] rotate_amount;
    reg rotate_direction;
    reg rotate_type;
    wire [31:0] data_out;

    // Instantiate the ShiftRotate module
    ShiftRotate uut (
        .data_in(data_in),
        .rotate_amount(rotate_amount),
        .rotate_direction(rotate_direction),
        .rotate_type(rotate_type),
        .data_out(data_out)
    );

    integer i;  // loop index for generating multiple test cases

    initial begin
        // Monitor changes
        $monitor("Time: %0d | Data In: %h | Rotate Amount: %d | Direction: %b | Type: %b | Data Out: %h",
                  $time, data_in, rotate_amount, rotate_direction, rotate_type, data_out);

        // Initial 4 tests (from original testbench):
        // Test 1: Shift Left by 4
        data_in = 32'hA5A5A5A5;
        rotate_amount = 5'd4;
        rotate_direction = 1'b0;  // Shift left
        rotate_type = 1'b0;  // Shift
        #10;

        // Test 2: Shift Right by 4
        rotate_direction = 1'b1;  // Shift right
        #10;

        // Test 3: Rotate Left by 4
        rotate_type = 1'b1;  // Rotate
        rotate_direction = 1'b0;  // Rotate left
        #10;

        // Test 4: Rotate Right by 4
        rotate_direction = 1'b1;  // Rotate right
        #10;

        // 200 additional tests:

        // Category 1: Shift by 0 to 31 bits (Left and Right)
        data_in = 32'hCAFEBABE;  // Arbitrary value for testing
        for (i = 0; i < 32; i = i + 1) begin
            rotate_amount = i[4:0];

            // Shift Left
            rotate_type = 1'b0;
            rotate_direction = 1'b0;
            #10;

            // Shift Right
            rotate_direction = 1'b1;
            #10;
        end

        // Category 2: Rotate by 0 to 31 bits (Left and Right)
        data_in = 32'hDEADBEEF;  // Arbitrary value for testing
        for (i = 0; i < 32; i = i + 1) begin
            rotate_amount = i[4:0];

            // Rotate Left
            rotate_type = 1'b1;
            rotate_direction = 1'b0;
            #10;

            // Rotate Right
            rotate_direction = 1'b1;
            #10;
        end

        // Category 3: Boundary and Edge Cases
        // Test shifting and rotating with different key values:
        // Max value, min value, alternating bits, etc.

        // Test 1: All 1's - Shift Left and Right
        data_in = 32'hFFFFFFFF;
        for (i = 0; i < 32; i = i + 1) begin
            rotate_amount = i[4:0];
            rotate_type = 1'b0;  // Shift
            rotate_direction = 1'b0;  // Shift Left
            #10;
            rotate_direction = 1'b1;  // Shift Right
            #10;
        end

        // Test 2: All 0's - Shift Left and Right
        data_in = 32'h00000000;
        for (i = 0; i < 32; i = i + 1) begin
            rotate_amount = i[4:0];
            rotate_type = 1'b0;  // Shift
            rotate_direction = 1'b0;  // Shift Left
            #10;
            rotate_direction = 1'b1;  // Shift Right
            #10;
        end

        // Test 3: Alternating bits 1 and 0 (0xAAAAAAAA) - Shift Left and Right
        data_in = 32'hAAAAAAAA;
        for (i = 0; i < 32; i = i + 1) begin
            rotate_amount = i[4:0];
            rotate_type = 1'b0;  // Shift
            rotate_direction = 1'b0;  // Shift Left
            #10;
            rotate_direction = 1'b1;  // Shift Right
            #10;
        end

        // Test 4: Alternating bits 0 and 1 (0x55555555) - Shift Left and Right
        data_in = 32'h55555555;
        for (i = 0; i < 32; i = i + 1) begin
            rotate_amount = i[4:0];
            rotate_type = 1'b0;  // Shift
            rotate_direction = 1'b0;  // Shift Left
            #10;
            rotate_direction = 1'b1;  // Shift Right
            #10;
        end

        // Test 5: All 1's - Rotate Left and Right
        data_in = 32'hFFFFFFFF;
        for (i = 0; i < 32; i = i + 1) begin
            rotate_amount = i[4:0];
            rotate_type = 1'b1;  // Rotate
            rotate_direction = 1'b0;  // Rotate Left
            #10;
            rotate_direction = 1'b1;  // Rotate Right
            #10;
        end

        // Test 6: All 0's - Rotate Left and Right
        data_in = 32'h00000000;
        for (i = 0; i < 32; i = i + 1) begin
            rotate_amount = i[4:0];
            rotate_type = 1'b1;  // Rotate
            rotate_direction = 1'b0;  // Rotate Left
            #10;
            rotate_direction = 1'b1;  // Rotate Right
            #10;
        end

        // Test 7: Alternating bits 1 and 0 (0xAAAAAAAA) - Rotate Left and Right
        data_in = 32'hAAAAAAAA;
        for (i = 0; i < 32; i = i + 1) begin
            rotate_amount = i[4:0];
            rotate_type = 1'b1;  // Rotate
            rotate_direction = 1'b0;  // Rotate Left
            #10;
            rotate_direction = 1'b1;  // Rotate Right
            #10;
        end

        // Test 8: Alternating bits 0 and 1 (0x55555555) - Rotate Left and Right
        data_in = 32'h55555555;
        for (i = 0; i < 32; i = i + 1) begin
            rotate_amount = i[4:0];
            rotate_type = 1'b1;  // Rotate
            rotate_direction = 1'b0;  // Rotate Left
            #10;
            rotate_direction = 1'b1;  // Rotate Right
            #10;
        end

        // Test 9: Random data values with random rotate amounts and directions
        data_in = 32'hDEADBEEF;
        for (i = 0; i < 32; i = i + 1) begin
            rotate_amount = i[4:0];
            rotate_type = $random % 2;  // Randomly choose Shift or Rotate
            rotate_direction = $random % 2;  // Randomly choose Left or Right
            #10;
        end

        // Test 10: Random Input Data with 0 to 31 shifts
        data_in = $random;
        for (i = 0; i < 32; i = i + 1) begin
            rotate_amount = i[4:0];
            rotate_type = $random % 2;  // Randomly choose Shift or Rotate
            rotate_direction = $random % 2;  // Randomly choose Left or Right
            #10;
        end

        // Test 11: Shift by 0 (No shift or rotate)
        data_in = 32'h12345678;
        rotate_amount = 5'd0;
        rotate_type = 1'b0;  // Shift
        rotate_direction = 1'b0;  // Shift Left
        #10;
        rotate_direction = 1'b1;  // Shift Right
        #10;

        // Test 12: Shift or Rotate by the Maximum Value (31 bits)
        data_in = 32'h12345678;
        rotate_amount = 5'd31;
        rotate_type = 1'b0;  // Shift
        rotate_direction = 1'b0;  // Shift Left
        #10;
        rotate_direction = 1'b1;  // Shift Right
        #10;

        // Test 13: A large random set of tests with different rotations
        for (i = 0; i < 50; i = i + 1) begin
            data_in = $random;
            rotate_amount = $random % 32;
            rotate_type = $random % 2;
            rotate_direction = $random % 2;
            #10;
        end

        // End the simulation after all test cases
        $stop;
    end
endmodule
