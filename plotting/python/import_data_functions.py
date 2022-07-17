import pandas as pd
from pathlib import Path


def import_data(alpha: float, M: float, dataset: str, config: str, case: str = 'fsi', parent_dir: str = "C:\\Users\\jackh\\OneDrive\\Python\\aeroelasticity_research\\onera-m6-modified"):
    """Imports data from a space-delimited text file and stores it as a DataFrame.

    Args:
        alpha (float): Angle of attack.
        M (float): Mach number.
        dataset (str): Data to be imported.
        config (str): Wing configuration to be imported.
        case (str, optional): Type of analysis data. May be 'rigid' or 'fsi'. Defaults to 'fsi'.
        parent_dir (str, optional): The parent location of the data folder. Defaults to "C:\\Users\\jackh\\OneDrive\\Python\\aeroelasticity_research\\onera-m6-modified".

    Returns:
        DataFrame: All data of specified dataset.
    """

    # Format angle of attack and Mach number for file name.
    alpha_str = ('%.0f' %alpha)
    M_str = ('%.2f' %M)

    # Get wing-configuration-specific report folder based on inputs.
    match config:
        case 'winglet':
            config_folder = "mod-winglet/reports"
        case 'extension':
            config_folder = "mod-extension/reports"
        case 'basic':
            config_folder = "mod-basic/reports"

    # Get dataset-specific report folder and report file name stem from inputs.
    match dataset:
        case 'disp': 
            report_folder = "displacement-data"
            report_file = "report-displacement-data-%s-%s.out" % (alpha_str, M_str)
        case 'stress':
            report_folder = "stress-data"
            report_file = "report-stress-data-%s-%s.out" % (alpha_str, M_str)
        case 'aero':
            report_folder = "aero-coefs"
            report_file = "report-aero-coefs-%s-%s.out" % (alpha_str, M_str)
        case 'numerics':
            report_folder = "analysis-numerics"
            report_file = "report-analysis-numerics-%s-%s.out" % (alpha_str, M_str)

    # Constructs the report directory path from the parent directory, config-specific path, and the analysis case.
    data_file = Path(parent_dir) / config_folder / case / report_folder / report_file

    with open(data_file,'r') as data_file_open:

        # Gets variable names from text file.
        all_lines = data_file_open.readlines()
        var_names = all_lines[2]

        # Shorten variable names and trim symbols.
        var_names = var_names.replace("Time Step","step").replace("displacement","disp").replace("flow-time","time").replace("\"","").replace("(","").replace(")","").split()

        # Imports contents of the data file into a DataFrame.
        simulation_data = pd.read_csv(data_file,sep=' ',skiprows=3)

    # Assign variable names to the columns of the DataFrame.
    simulation_data.columns = var_names

    # Round time values to remove floating point imprecision.
    simulation_data['time'] = simulation_data['time'].round(4)

    # Print status to console.
    print('[  Import: \u03B1=%s, M=%s  ]' % (alpha_str, M_str))
        
    return simulation_data


def import_disp(alpha: float, M: float, config: str, component: str = 'z', location: str = 'wingtip', station: float = 1.00, case: str = 'fsi', parent_dir: str = r"C:\\Users\\jackh\\OneDrive\\Python\\aeroelasticity_research\\onera-m6-modified"):
    """Imports displacement data at a specified location on the wing.

    Args:
        alpha (float): Angle of attack.
        M (float): Mach number.
        config (str): Wing configuration to be imported.
        component (str, optional): Component of displacement vector. Defaults to 'z'.
        location (str, optional): Leading-edge ('le'), trailing-edge ('te'), or wingtip of wing. Defaults to 'wingtip'.
        station (float, optional): Normalized distance along the span. Defaults to 1.00.
        case (str, optional): Type of analysis data. May be 'rigid' or 'fsi'. Defaults to 'fsi'.
        parent_dir (str, optional): The parent location of the data folder. Defaults to "C:\\Users\\jackh\\OneDrive\\Python\\aeroelasticity_research\\onera-m6-modified".

    Returns:
        list: An ordered pair of time and displacement data: [time, displacement_data].
    """

    # Format the station input variable for use as a variable name key.
    station_str = ('%.2f' %station)

    # Use the "import_data" function to retrieve displacement data as a DataFrame.
    simulation_data = import_data(alpha=alpha, M=M, dataset='disp', config=config, case=case, parent_dir=parent_dir)

    # Get time vector from the DataFrame.
    x = simulation_data['time']

    # Construct data vector name based on function inputs.
    if location == 'wingtip':
        vector_name = 'sp-wingtip-%s-disp' % component
    else:
        vector_name = 'sp-%s-%s-%s-disp' % (location, station_str, component)

    # Get the displacement data vector from the DataFrame.
    y = simulation_data[vector_name]

    return [x, y]


def import_stress(alpha: float, M: float, config: str, component: str = 'equ', case: str = 'fsi', parent_dir: str = r"C:\\Users\\jackh\\OneDrive\\Python\\aeroelasticity_research\\onera-m6-modified"):
    """Imports the global maximum of the specified stress metric/component versus time.

    Args:
        alpha (float): Angle of attack.
        M (float): Mach number.
        config (str): Wing configuration to be imported.
        component (str, optional): Either tensor component or equivalent stress. Defaults to 'equ'.
        case (str, optional): Type of analysis data. May be 'rigid' or 'fsi'. Defaults to 'fsi'.
        parent_dir (str, optional): The parent location of the data folder. Defaults to "C:\\Users\\jackh\\OneDrive\\Python\\aeroelasticity_research\\onera-m6-modified".

    Returns:
        list: An ordered pair of time and stress data: [time, stress_data].
    """

    # Use the "import_data" function to retrieve stress data as a DataFrame.
    simulation_data = import_data(alpha=alpha, M=M, dataset='stress', config=config, case=case, parent_dir=parent_dir)

    # Get time vector from the DataFrame.
    x = simulation_data['time']

    # Construct data vector name based on function inputs.
    if component == 'equ':
        vector_name = 'wing-equ-stress'
    else:
        vector_name = 'wing-sigma-%s' % component

    # Get the stress data vector from the DataFrame.
    y = simulation_data[vector_name]

    return [x, y]