#include "inc/dpm_policies.h"
#include "inc/psm.h"

int init_params(char *fwl, psm_t *psm, int wl_id);

int simulate_different_timeouts(char *fwl, psm_t psm, dpm_policy_t *selected_policy, dpm_timeout_params *tparams, dpm_history_params *hparams);