//------------------------------------------------------------------------------
// cc_types
//------------------------------------------------------------------------------
typedef bit [63:0] addr_t;
typedef enum {PrRd, PrWr,
              BusRd, BusRdX,
              PrRdS, PrRdNS, BusUpgr} operation_t;
typedef enum {state_M, state_E, state_S,
              state_I, state_O} state_t;

