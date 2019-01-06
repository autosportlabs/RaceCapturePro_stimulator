[#ftl]
[@pp.dropOutputFile /]
[@pp.changeOutputFile name="hal_adc_lld_cfg.h" /]
/*
    SPC5 HAL - Copyright (C) 2013 STMicroelectronics

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

/**
 * @file    hal_adc_lld_cfg.h
 * @brief   ADC Driver configuration macros and structures.
 *
 * @addtogroup ADC
 * @{
 */

#ifndef _ADC_LLD_CFG_H_
#define _ADC_LLD_CFG_H_

#if HAL_USE_ADC || defined(__DOXYGEN__)

/*===========================================================================*/
/* Driver constants.                                                         */
/*===========================================================================*/

/**
 * @name    Conversion groups constants
 * @{
 */
[#list conf.instance.adc_settings.adc0_conversion_groups.configs.conversion_group_settings as group]
  [#assign name = group.symbolic_name.value[0]?upper_case /]
#define ADC0_GROUP_${name}_NUM_CHANNELS ${group.channels.number_of_channels.value[0]}
#define ADC0_GROUP_${name}_BUF_DEPTH    ${group.maximum_sequential.value[0]}
  [#if group_has_next]

  [/#if]
[/#list]
[#list conf.instance.adc_settings.adc1_conversion_groups.configs.conversion_group_settings as group]
  [#assign name = group.symbolic_name.value[0]?upper_case /]
#define ADC1_GROUP_${name}_NUM_CHANNELS ${group.channels.number_of_channels.value[0]}
#define ADC1_GROUP_${name}_BUF_DEPTH    ${group.maximum_sequential.value[0]}
  [#if group_has_next]

  [/#if]
[/#list]
/** @} */

/*===========================================================================*/
/* Driver pre-compile time settings.                                         */
/*===========================================================================*/

/*===========================================================================*/
/* Derived constants and error checks.                                       */
/*===========================================================================*/

/*===========================================================================*/
/* Driver data structures and types.                                         */
/*===========================================================================*/

/*===========================================================================*/
/* Driver macros.                                                            */
/*===========================================================================*/

/*===========================================================================*/
/* External declarations.                                                    */
/*===========================================================================*/

/* List of the ADC0 ADCConversionGroup structures defined in adc_lld_cfg.c.*/
[#list conf.instance.adc_settings.adc0_conversion_groups.configs.conversion_group_settings as group]
extern const ADCConversionGroup adc0_group_${group.symbolic_name.value[0]?trim};
[/#list]

/* List of the ADC1 ADCConversionGroup structures defined in adc_lld_cfg.c.*/
[#list conf.instance.adc_settings.adc1_conversion_groups.configs.conversion_group_settings as group]
extern const ADCConversionGroup adc1_group_${group.symbolic_name.value[0]?trim};
[/#list]

#ifdef __cplusplus
extern "C" {
#endif
  /* List of the callback functions referenced from the ADC0 ADCConversionGroup
     structures in adc_lld_cfg.c.*/
[#assign conv_callbacks = []]
[#assign err_callbacks = []]
[#list conf.instance.adc_settings.adc0_conversion_groups.configs.conversion_group_settings as group]
  [#assign conv_cb = group.notifications.conversion_callback.value[0]?string?trim /]
  [#if conv_cb != ""]
    [#if !conv_callbacks?seq_contains(conv_cb)]
      [#assign conv_callbacks = conv_callbacks + [conv_cb]]
    [/#if]
  [/#if]
  [#assign err_cb = group.notifications.error_callback.value[0]?string?trim /]
  [#if err_cb != ""]
    [#if !err_callbacks?seq_contains(err_cb)]
      [#assign err_callbacks = err_callbacks + [err_cb]]
    [/#if]
  [/#if]
[/#list]
[#list conv_callbacks?sort as cb]
  void ${cb}(ADCDriver *adcp, adcsample_t *buffer, size_t n);
[/#list]
[#list err_callbacks?sort as cb]
  void ${cb}(ADCDriver *adcp, adcerror_t err);
[/#list]

  /* List of the callback functions referenced from the ADC1 ADCConversionGroup
     structures in adc_lld_cfg.c.*/
[#assign conv_callbacks = []]
[#assign err_callbacks = []]
[#list conf.instance.adc_settings.adc1_conversion_groups.configs.conversion_group_settings as group]
  [#assign conv_cb = group.notifications.conversion_callback.value[0]?string?trim /]
  [#if conv_cb != ""]
    [#if !conv_callbacks?seq_contains(conv_cb)]
      [#assign conv_callbacks = conv_callbacks + [conv_cb]]
    [/#if]
  [/#if]
  [#assign err_cb = group.notifications.error_callback.value[0]?string?trim /]
  [#if err_cb != ""]
    [#if !err_callbacks?seq_contains(err_cb)]
      [#assign err_callbacks = err_callbacks + [err_cb]]
    [/#if]
  [/#if]
[/#list]
[#list conv_callbacks?sort as cb]
  void ${cb}(ADCDriver *adcp, adcsample_t *buffer, size_t n);
[/#list]
[#list err_callbacks?sort as cb]
  void ${cb}(ADCDriver *adcp, adcerror_t err);
[/#list]
#ifdef __cplusplus
}
#endif

#endif /* HAL_USE_ADC */

#endif /* _ADC_LLD_CFG_H_ */

/** @} */
