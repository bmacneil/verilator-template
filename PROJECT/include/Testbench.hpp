#ifndef TESTBENCH_HPP
#define TESTBENCH_HPP


#include "VMODULENAME.h"
#include "verilated.h"
#include <verilated_vcd_c.h>
#include "port.hpp"
#include <iostream>
#include <string>


class Testbench {
public:
    unsigned long   m_tickcount;
    VMODULENAME  *m_core;
    OUTPUT_PORT *testPort;
    VerilatedVcdC   *m_trace;
    std::string version = "v1.0";
    std::string error_msg = "";
    bool trace_on;

    Testbench(bool trace_state = false);

    ~Testbench(void);

    void print_version(void);

    void reset(void);

    // Open/create a trace file
    void open_trace(const char *vcdname);

    void close_trace(void);

    void tick(void);

    void eval(void);

    // bool run_tests(std::string, int);

    bool done(void);
};


#endif //TESTBENCH_HPP