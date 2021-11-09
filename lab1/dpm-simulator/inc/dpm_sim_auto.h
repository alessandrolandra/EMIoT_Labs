#include "inc/dpm_policies.h"
#include "inc/psm.h"

int init_params(char *fwl, psm_t *psm, psm_time_t *t_be, int8_t wl_id, int8_t is_idle_allowed);

int simulate_different_timeouts(char *fwl, psm_t psm, dpm_policy_t *selected_policy, dpm_timeout_params *tparams, dpm_history_params *hparams, int8_t is_idle_allowed, psm_time_t t_be);