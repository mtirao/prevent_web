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
  def render_to_gyncoligies(page, conn, error_type, adult) do

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
                teen_boarding: "false",
                userrole: get_session(conn, :userrole))

  end

  #Render an Pediatricss page base on pediatrics map.
  #And if an error ocurrer it render the error base in error_type.
  def render_to_pediatrics(page, conn, error_type, adult) do

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
                teen_boarding: "false",
                userrole: get_session(conn, :userrole))

  end

  #Render an Obstetrics page base on obstetrics map.
  #And if an error ocurrer it render the error base in error_type.
  def render_to_obstetrics(page, conn, error_type, adult) do

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
                teen_boarding: "false",
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
