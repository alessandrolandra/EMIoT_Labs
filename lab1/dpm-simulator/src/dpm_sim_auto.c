/**
 * @brief The main DPM simulator program
 */

#include "inc/dpm_sim_auto.h"
#include <string.h>

#define PSM_PATH "example/psm.txt"
#define WL1_PATH "../workloads/workload_1.txt"
#define WL2_PATH "../workloads/workload_2.txt"
#define WL3_PATH "../workloads/workload_3.txt"

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
        case 3:
            strcpy(fwl, WL3_PATH);
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

static int set_history_policy(dpm_policy_t *selected_policy){
    *selected_policy = DPM_HISTORY;
    return 0;
}

static int init_history_params(dpm_history_params *hparams){
    hparams->alpha[4] = 0.45;
    hparams->alpha[3] = 0.25;
    hparams->alpha[2] = 0.15;
    hparams->alpha[1] = 0.10;
    hparams->alpha[0] = 0.05;
    return 0;
}

static int set_history_threshold(dpm_history_params *hparams, double threshold){
    hparams->threshold[0] = threshold;
    return 0;
}

int init_params(char *fwl, psm_t *psm, psm_time_t *t_be, int8_t wl_id, int8_t is_idle_allowed) {
    init_psm(psm);
    init_tbe(*psm,t_be,is_idle_allowed);
    load_wl(fwl,wl_id);
    return 0;
}

int simulate_different_timeouts(char *fwl, psm_t psm, dpm_policy_t *selected_policy, dpm_timeout_params *tparams, dpm_history_params *hparams, int8_t is_idle_allowed, psm_time_t t_be, int start_timeout, int end_timeout) {
    set_timeout_policy(selected_policy);
    for(int i=start_timeout;i<=end_timeout;i++) {
        set_timeout(tparams, (float)i);
        dpm_simulate(psm, *selected_policy, *tparams, *hparams, fwl, is_idle_allowed);
    }
    return 0;
}

int simulate_different_history_thresholds(char *fwl, psm_t psm, dpm_policy_t *selected_policy, dpm_timeout_params *tparams, dpm_history_params *hparams, int8_t is_idle_allowed, psm_time_t t_be, int start_threshold, int end_threshold) {
    set_history_policy(selected_policy);
    init_history_params(hparams);
    for(int i=start_threshold;i<=end_threshold;i++) {
        set_history_threshold(hparams, (float)i);
        dpm_simulate(psm, *selected_policy, *tparams, *hparams, fwl, is_idle_allowed);
    }
    return 0;
}