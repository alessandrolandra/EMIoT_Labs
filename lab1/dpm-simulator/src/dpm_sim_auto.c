/**
 * @brief The main DPM simulator program
 */

#include "inc/dpm_sim_auto.h"
#include <string.h>

#define PSM_PATH "example/psm.txt"
#define WL1_PATH "../workloads/workload_1.txt"
#define WL2_PATH "../workloads/workload_2.txt"

//#define PRINT //uncomment to print

static int init_psm(psm_t *psm){
     return psm_read(psm, PSM_PATH);
}

static int load_wl(char *fwl, int id){
    switch(id){
        case 1:
            strcpy(fwl, WL1_PATH);
            break;
        case 2:
            strcpy(fwl, WL2_PATH);
            break;
        default:
            strcpy(fwl, WL1_PATH);
    }
    return 0;
}

static int set_timeout(dpm_policy_t *selected_policy, dpm_timeout_params *tparams, float to){
    *selected_policy = DPM_TIMEOUT;
    tparams->timeout = to;
    return 0;
}

/*int set_policy(dpm_policy_t *selected_policy, dpm_history_params *hparams){
    *selected_policy = DPM_HISTORY;
    int i;
    for(i = 0; i < DPM_HIST_WIND_SIZE; i++) {
        hparams->alpha[i] = atof(argv[++cur]);
    }
    hparams->threshold[0] = atof(argv[++cur]);
    hparams->threshold[1] = atof(argv[++cur]);
}*/

int init_params(char *fwl, psm_t *psm, dpm_policy_t *selected_policy, dpm_timeout_params *tparams, dpm_history_params *hparams, int wl_id) {
    init_psm(psm);
    load_wl(fwl,wl_id);
    set_timeout(selected_policy, tparams, 0);
    return 0;
}

int simulate_different_timeouts(char *fwl, psm_t psm, dpm_policy_t *selected_policy, dpm_timeout_params *tparams, dpm_history_params *hparams) {
    for(int i=0;i<200;i++) {
        if(i>0) {
            set_timeout(selected_policy, tparams, (float)i);
        }else{
            set_timeout(selected_policy, tparams, 0);
        }
        printf("%d\t",i);
        #ifdef PRINT
            psm_print(psm);
        #endif
        dpm_simulate(psm, *selected_policy, *tparams, *hparams, fwl);
    }
    return 0;
}