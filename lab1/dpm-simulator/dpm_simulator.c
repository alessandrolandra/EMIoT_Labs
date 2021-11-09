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

    if(argc==1){
        init_params(fwl, &psm, 2);
        simulate_different_timeouts(fwl, psm, &sel_policy, &tparams, &hparams);
    }else if(!parse_args(argc, argv, fwl, &psm, &sel_policy, &tparams, &hparams)) {
        printf("[error] reading command line arguments\n");
        return -1;
    }

    return 0;
}
