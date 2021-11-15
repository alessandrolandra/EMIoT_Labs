/**
 * @brief The main DPM simulator program
 */

#include "inc/psm.h"
#include "inc/dpm_policies.h"
#include "inc/utilities.h"
#include "inc/dpm_sim_auto.h"

#define MAX_FILENAME 256

int main(int argc, char *argv[]) {

    char fwl[MAX_FILENAME];
    psm_t psm;
    dpm_timeout_params tparams;
    dpm_history_params hparams;
    dpm_policy_t sel_policy;
    psm_time_t t_be;
    int8_t wl_id = 2;
    int8_t is_idle_allowed = 0;

    if(argc==1){
        init_params(fwl, &psm, &t_be, wl_id, is_idle_allowed);
        simulate_different_timeouts(fwl, psm, &sel_policy, &tparams, &hparams, is_idle_allowed, t_be);
    }else{
        if(!parse_args(argc, argv, fwl, &psm, &sel_policy, &tparams, &hparams)) {
            printf("[error] reading command line arguments\n");
            return -1;
        }
        psm_print(psm);
        dpm_simulate(psm, sel_policy, tparams, hparams, fwl, is_idle_allowed);
    }

    return 0;
}
