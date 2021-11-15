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

static int set_timeout_policy(dpm_policy_t *selected_policy){
    *selected_policy = DPM_TIMEOUT;
    return 0;
}

static int set_timeout(dpm_timeout_params *tparams, float to){
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

int init_params(char *fwl, psm_t *psm, psm_time_t *t_be, int8_t wl_id, int8_t is_idle_allowed) {
    init_psm(psm);
    init_tbe(*psm,t_be,is_idle_allowed);
    load_wl(fwl,wl_id);
    return 0;
}

int simulate_different_timeouts(char *fwl, psm_t psm, dpm_policy_t *selected_policy, dpm_timeout_params *tparams, dpm_history_params *hparams, int8_t is_idle_allowed, psm_time_t t_be) {
    set_timeout_policy(selected_policy);
    //for(int i=0;i<200;i++) {
    for(int i=0;i<t_be;i++) {
        set_timeout(tparams, (float)i);
        //printf("%d\t",i);
        printf("Timeout: %d\n",i);
        #ifdef PRINT
            psm_print(psm);
            printf("[added parameter] t_be: %f\n",t_be);
        #endif
        dpm_simulate(psm, *selected_policy, *tparams, *hparams, fwl, is_idle_allowed);
    }
    return 0;
}