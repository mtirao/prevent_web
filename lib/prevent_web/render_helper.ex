#Helper for all rendering related functions.

defmodule RenderHelper do
  use PreventWeb, :controller


  #Render an Adult page base on adult map.
  #And if an error ocurrer it render the error base in error_type.
  def render_to_adult(page, conn, error_type, adult) do

    token = get_csrf_token()

    nutritional_value_normal = selection_value(adult["nutritionalvalue"], 1)
    nutritional_value_overweight = selection_value(adult["nutritionalvalue"], 2)
    nutritional_value_obesity = selection_value(adult["nutritionalvalue"], 3)
    nutritional_value_underweight = selection_value(adult["nutritionalvalue"], 4)
    nutritional_monitoring = if adult["nutritionalmonitoring"], do: "checked", else: ""
    blood_monitoring = if adult["bloodpressuremonitoring"], do: "checked", else: ""
    glucose_monitoring = if adult["glucosemonitoring"], do: "checked", else: ""
    lipid_disorder_monitoring = if adult["lipiddisordermonitoring"], do: "checked", else: ""
    diabetes_treatment_no = selection_value(adult["diabetestreatment"], 1)
    diabetes_treatment_ado = selection_value(adult["diabetestreatment"], 2)
    diabetes_treatment_insulin = selection_value(adult["diabetestreatment"], 3)
    diabetes_treatment_ditetic_hygiene = selection_value(adult["diabetestreatment"], 4)
    lipid_disorder_200 = selection_value(adult["lipiddisorder"], 1)
    lipid_disorder_160 = selection_value(adult["lipiddisorder"], 2)
    lipid_disorder_40 = selection_value(adult["lipiddisorder"], 3)
    lipid_disorder_150 = selection_value(adult["lipiddisorder"], 4)
    lipid_disorder_treament_yes = selection_value(adult["lipisdisordertreatment"], 1)
    lipid_disorder_treament_no = selection_value(adult["lipisdisordertreatment"], 2)
    lipid_disorder_treament_monitoring = selection_value(adult["lipisdisordertreatment"], 3)
    immunization_complete = selection_value(adult["lipisdisordertreatment"], 1)
    immunization_incomplete = selection_value(adult["lipisdisordertreatment"], 2)
    immunization_nd = selection_value(adult["lipisdisordertreatment"], 3)
    smoking_cessation_never_smoke = selection_value(adult["smokingcessation"], 1)
    smoking_cessation_smoke = selection_value(adult["smokingcessation"], 2)
    smoking_cessation_former_smoker = selection_value(adult["smokingcessation"], 3)

    diabetes_normal = selection_value(adult["diabetes"], 1)
    diabetes_peripheral_resistance = selection_value(adult["diabetes"], 2)
    diabetes_dbt_I = selection_value(adult["diabetes"], 2)
    diabetes_dbt_II = selection_value(adult["diabetes"], 2)

    blood_pressure_systolic =  if adult["bloodpressuresystolic"] == nil, do: "", else: adult["bloodpressuresystolic"]
    blood_pressure_diastolic = if adult["bloodpressurediastolic"] == nil, do: "", else: adult["bloodpressurediastolic"]


    render(conn, page,  error_type: error_type, csrf_token: token,
                nutritional_value_normal: nutritional_value_normal,
                nutritional_value_overweight: nutritional_value_overweight,
                nutritional_value_obesity: nutritional_value_obesity,
                nutritional_value_underweight: nutritional_value_underweight,
                nutritional_monitoring: nutritional_monitoring,
                blood_pressure_systolic:  blood_pressure_systolic,
                blood_pressure_diastolic: blood_pressure_diastolic,
                blood_monitoring: blood_monitoring,
                glucose_monitoring: glucose_monitoring,
                lipid_disorder_monitoring: lipid_disorder_monitoring,
                diabetes_treatment_no: diabetes_treatment_no,
                diabetes_treatment_ado: diabetes_treatment_ado,
                diabetes_treatment_insulin: diabetes_treatment_insulin,
                diabetes_treatment_dietetic_hygiene: diabetes_treatment_ditetic_hygiene,
                lipid_disorder_200: lipid_disorder_200,
                lipid_disorder_160: lipid_disorder_160,
                lipid_disorder_40: lipid_disorder_40,
                lipid_disorder_150: lipid_disorder_150,
                lipid_disorder_treament_yes: lipid_disorder_treament_yes,
                lipid_disorder_treament_no: lipid_disorder_treament_no,
                lipid_disorder_treament_monitoring: lipid_disorder_treament_monitoring,
                immunization_complete: immunization_complete,
                immunization_incomplete: immunization_incomplete,
                immunization_nd: immunization_nd,
                smoking_cessation_never_smoke: smoking_cessation_never_smoke,
                smoking_cessation_smoke: smoking_cessation_smoke,
                smoking_cessation_former_smoker: smoking_cessation_former_smoker,
                diabetes_normal: diabetes_normal,
                diabetes_peripheral_resistance: diabetes_peripheral_resistance,
                diabetes_dbt_I: diabetes_dbt_I,
                diabetes_dbt_II: diabetes_dbt_II,
                patient_id: adult["patient_id"],
                userrole: get_session(conn, :userrole))

  end


  #Render an Gyncoligies page base on gyncoligies map.
  #And if an error ocurrer it render the error base in error_type.
  def render_to_gyncoligies(page, conn, error_type, gynocology) do

    token = get_csrf_token()


    cevicouterino_tracking = ""
    birth_control = ""
    hpv_immunization = ""
    last_pap_result = ""
    teen_boarding = ""
    tracking_its = ""

    render(conn, page,  error_type: error_type, csrf_token: token,
                cevicouterino_tracking: cevicouterino_tracking,
                birth_control: birth_control,
                hpv_immunization: hpv_immunization,
                last_pap_result: last_pap_result,
                teen_boarding: teen_boarding ,
                tracking_its:  tracking_its,
                patient_id: gynocology["patient_id"],
                userrole: "admin") #get_session(conn, :userrole))

  end

  #Render an Pediatricss page base on pediatrics map.
  #And if an error ocurrer it render the error base in error_type.
  def render_to_pediatrics(page, conn, error_type, adult) do

    token = get_csrf_token()

    accidentpreventionpromo = selection_value(adult["accidentpreventionprom"], 1)
    breastfeeding = selection_value(adult["breastfeedin"], 1)
    breastfeedingpromotion = selection_value(adult["breastfeedingpromotion"], 1)
    immunization = selection_value(adult["immunization"], 1)
    mentalhealth = selection_value(adult["mentalhealth"], 1)
    nutritionalpromotion = selection_value(adult["nutritionalpromotion"], 1)
    nutritionalstatus = selection_value(adult["nutritionalstatus"], 1)
    oralhealth = selection_value(adult["oralhealth"], 1)
    oralhealthpromotion = selection_value(adult["oralhealthpromotion"], 1)
    trackhearingproblems = selection_value(adult["trackhearingproblems"], 1)
    trackmetabolicproblems = selection_value(adult["trackmetabolicproblems"], 1)
    trackophthalmologicalproblems = selection_value(adult["trackophthalmologicalproblems"], 1)

    render(conn, page,  error_type: error_type, csrf_token: token,
                accidentpreventionpromo: accidentpreventionpromo,
                breastfeeding: breastfeeding,
                breastfeedingpromotion: breastfeedingpromotion,
                inmunization: immunization,
                mentalhealth: mentalhealth,
                nutritionalpromotion: nutritionalpromotion,
                nutritionalstatus: nutritionalstatus,
                oralhealth: oralhealth,
                oralhealthpromotion: oralhealthpromotion,
                trackhearingproblems: trackhearingproblems,
                trackmetabolicproblems: trackmetabolicproblems,
                trackophthalmologicalproblems: trackophthalmologicalproblems,
                patient_id: adult["patient_id"],
                userrole: get_session(conn, :userrole))

  end

  #Render an Obstetrics page base on obstetrics map.
  #And if an error ocurrer it render the error base in error_type.
  def render_to_obstetrics(page, conn, error_type, obstetrics) do

    token = get_csrf_token()

    breastfeeding = ""
    immunization = ""
    its_promotion = ""
    nutritional_status = ""
    nutritional_status_treatment = ""
    perinatal_investigation = ""
    physical_activity_prescription = ""
    problematic_consuption = ""
    psychoprophylaxis = ""

    render(conn, page,  error_type: error_type, csrf_token: token,
                breastfeeding: breastfeeding,
                immunization: immunization,
                its_promotion: its_promotion,
                nutritional_status: nutritional_status,
                nutritional_status_treatment: nutritional_status_treatment,
                perinatal_investigation: perinatal_investigation,
                physical_activity_prescription: physical_activity_prescription,
                problematic_consuption: problematic_consuption,
                psychoprophylaxis: psychoprophylaxis,
                patient_id: obstetrics["patient_id"],
                userrole: get_session(conn, :userrole))

  end

  #Convert from HTML Form to json and pass the result to the Api.
  def parameters_to_json_adult(params) do

    bloodpressureddias = Helper.string_to_integer(params["blood_pressure_diastolic"])
    bloodpressuremonitoring = Helper.string_to_boolean(params["blood_monitoring"])
    bloodpressuresystolic = Helper.string_to_integer(params["blood_pressure_systolic"])
    date = NaiveDateTime.to_iso8601(NaiveDateTime.utc_now)

    diabetes = Helper.string_to_integer(params["diabetes"])

    glocusemonitoring = Helper.string_to_boolean(params["glocuse_monitoring"])

    diabetestreatment = Helper.string_to_integer(params["diabetes_treatment"])

    lipidisorder = Helper.string_to_integer(params["lipid_disorder"])
    lipiddisordermonitoring = Helper.string_to_boolean(params["lipiddisordermonitoring"])
    lipisdisordertreatment = Helper.string_to_integer(params["lipid_disorder_treament"])

    immunization = Helper.string_to_integer(params["immunization"])
    nutritionalmonitoring =  Helper.string_to_boolean(params["nutritional_monitoring"])

    height = Helper.string_to_float(params["height"]) / 100.0
    weight = Helper.string_to_float(params["weight"])

    IO.puts("Nutritional value:#{params["nutritional_value"]}")

    nutritionalvalue = if params["nutritional_value"] == nil, do: Helper.imc(height, weight), else:  Helper.string_to_integer(params["nutritional_value"])

    patientid = Helper.string_to_integer(params["patient_id"])

    smokingcessation = Helper.string_to_integer(params["smoking_cessation"])


    %{"bloodpressurediastolic" => bloodpressureddias,
      "bloodpressuresystolic" =>  bloodpressuresystolic,
      "bloodpressuremonitoring" => bloodpressuremonitoring,
      "date" => date,
      "diabetes" => diabetes,
      "diabetestreatment" => diabetestreatment,
      "glocusemonitoring" => glocusemonitoring,
      "immunization" => immunization,
      "lipiddisorder"=> lipidisorder,
      "lipiddisordermonitoring" => lipiddisordermonitoring,
      "lipisdisordertreatment" => lipisdisordertreatment,
      "nutritionalmonitoring" => nutritionalmonitoring,
      "nutritionalvalue" => nutritionalvalue,
      "patientid" => patientid,
      "smokingcessation" => smokingcessation
    }

  end

  def parameters_to_json_gynecology(params) do

    cevicouterinotracking = Helper.string_to_integer(params["cevicouterino_tracking"])
    birthcontrol = Helper.string_to_integer(params["birth_control"])
    hpvimmunization = Helper.string_to_integer(params["hpv_immunization"])
    lastpapresult = Helper.string_to_integer(params["last_pap_result"])
    teenboarding = Helper.string_to_boolean(params["teen_boarding"])
    trackingits = Helper.string_to_integer(params["tracking_its"])
    patientid = Helper.string_to_integer(params["patient_id"])

    %{"cevicouterinotracking" => cevicouterinotracking,
      "birthcontrol" => birthcontrol,
      "hpvimmunization" => hpvimmunization,
      "lastpapresult" => lastpapresult,
      "teenboarding" => teenboarding,
      "trackingits" => trackingits,
      "patientid" => patientid
    }

  end

  def parameters_to_json_obstetrics(params) do

    breastfeeding = Helper.string_to_integer(params["breastfeeding"])
    obstetricimmunization = Helper.string_to_integer(params["obstetric_immunization"])
    itspromotion = Helper.string_to_boolean(params["its_promotion"])
    nutritionalstatus = Helper.string_to_integer(params["nutritional_status"])
    nutritionalstatustreatment =  Helper.string_to_boolean(params["nutritional_statustreatment"])
    perinatalinvestigations = Helper.string_to_integer(params["perinatal_investigations"])
    physiscalactivityprescription = Helper.string_to_integer(params["physiscal_activity_prescription"])
    problmeticconsuption = Helper.string_to_integer(params["problmetic_consuption"])
    psychoprophylaxis = Helper.string_to_integer(params["psychoprophylaxis"])
    patientid = Helper.string_to_integer(params["patient_id"])


    %{"breastfeeding" => breastfeeding,
      "obstetricimmunization" => obstetricimmunization,
      "itspromotion" => itspromotion,
      "nutritionalstatus" => nutritionalstatus,
      "nutritionalstatustreatment" => nutritionalstatustreatment,
      "perinatalinvestigations" => perinatalinvestigations,
      "physiscalactivityprescription" => physiscalactivityprescription,
      "problmeticconsuption" => problmeticconsuption,
      "psychoprophylaxis" => psychoprophylaxis,
      "patientid" => patientid
    }
  end

  def parameters_to_json_pediatric(params) do

    accidentpreventionpromo = Helper.string_to_integer(params["accidentpreventionpromo"])
    breastfeeding = Helper.string_to_integer(params["breastfeeding"])
    breastfeedingpromotion = Helper.string_to_boolean(params["breastfeedingpromotion"])
    immunization = Helper.string_to_integer(params["immunization"])
    mentalhealth = Helper.string_to_integer(params["mentalhealth"])
    nutritionalpromotion = Helper.string_to_boolean(params["nutritionalpromotion"])
    nutritionalstatus = Helper.string_to_integer(params["nutritionalstatus"])
    oralhealth = Helper.string_to_integer(params["oralhealth"])
    oralhealthpromotion = Helper.string_to_boolean(params["oralhealthpromotion"])
    trackhearingproblems = Helper.string_to_integer(params["trackhearingproblems"])
    trackmetabolicproblems = Helper.string_to_integer(params["trackmetabolicproblems"])
    trackophthalmologicalproblems = Helper.string_to_integer(params["trackophthalmologicalproblems"])

    patientid = Helper.string_to_integer(params["patient_id"])

    %{"accidentpreventionpromo" => accidentpreventionpromo,
      "breastfeeding" => breastfeeding,
      "breastfeedingpromotion" => breastfeedingpromotion,
      "immunization" => immunization,
      "mentalhealth" => mentalhealth,
      "nutritionalpromotion" => nutritionalpromotion,
      "nutritionalstatus" => nutritionalstatus,
      "oralhealth" => oralhealth,
      "oralhealthpromotion" => oralhealthpromotion,
      "trackhearingproblems" => trackhearingproblems,
      "trackmetabolicproblems" => trackmetabolicproblems,
      "trackophthalmologicalproblems" => trackophthalmologicalproblems,
      "patientid" => patientid
    }
  end

  def selection_value(value, type) do

    cond do
      (value == 4) and (type == 4) -> "checked"
      (value == 1) and (type == 1) -> "checked"
      (value == 2) and (type == 2) -> "checked"
      (value == 3) and (type == 3) -> "checked"
      true -> ""
    end

  end

end
