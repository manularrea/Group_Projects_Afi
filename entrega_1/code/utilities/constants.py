# -*- coding: utf-8 -*-

names = ['id', 'age', 'gender', 'education', 'country', 'ethnicity', 'n_score', 'e_score', 'o_score',
         'a_score', 'c_score', 'impulsive', 'sensation_seeking', 'alcohol', 'amphet', 'amyl', 'benzos', 'caffeine',
         'cannabis', 'chocolate', 'cocaine', 'crack', 'ecstasy', 'heroin', 'ketamine', 'legal_highs',
         'lsd', 'methadone', 'mushrooms', 'nicotine', 'semer', 'vsa']

age_values = {-0.95197 : '18-24', -0.07854 : '25-34', 0.49788 : '35-44', 1.09449 : '45-54', 1.82213 : '55-64', 2.59171 : '65+'}

gender_values = {0.48246 : 'Female', -0.48246 : 'Male'}

education_values = {-2.43591 : 'Left school before 16 years',
                    -1.73790 : 'Left school at 16 years',
                    -1.43719 : 'Left school at 17 years',
                    -1.22751 : 'Left school at 18 years',
                    -0.61113 : 'Some college or university, no certificate or degree',
                    -0.05921 : 'Professional certificate/diploma',
                     0.45468 : 'University degree',
                     1.16365 : 'Masters degree',
                     1.98437 : 'Doctorate degree'}

country_values = {-0.09765 : 'Australia',
                   0.24923 : 'Canada',
                  -0.46841 : 'New Zealand',
                  -0.28519 : 'Other',
                   0.21128 : 'Republic of Ireland',
                   0.96082 : 'UK',
                  -0.57009 : 'USA'}

ethnicity_values = {-0.50212 : 'Asian',
                    -1.10702 : 'Black',
                     1.90725 : 'Mixed-Black/Asian',
                     0.12600 : 'Mixed-White/Asian',
                    -0.22166 : 'Mixed-White/Black',
                     0.11440 : 'Other',
                    -0.31685 : 'White'}

all_drugs_columns = ['alcohol', 'amphet', 'amyl', 'benzos', 'caffeine', 'cannabis', 'chocolate',
                 'cocaine', 'crack', 'ecstasy', 'heroin', 'ketamine', 'legal_highs',
                 'lsd', 'methadone', 'mushrooms', 'nicotine', 'semer', 'vsa']

drugs_columns = ['alcohol', 'amphet', 'amyl', 'benzos', 'caffeine', 'cannabis', 'chocolate',
                 'cocaine', 'crack', 'ecstasy', 'heroin', 'ketamine', 'legal_highs',
                 'lsd', 'methadone', 'mushrooms', 'nicotine', 'vsa']

drugs_values = {'CL0' : 'Never Used',
                'CL1' : 'Used over a Decade Ago',
                'CL2' : 'Used in Last Decade',
                'CL3' : 'Used in Last Year',
                'CL4' : 'Used in Last Month',
                'CL5' : 'Used in Last Week',
                'CL6' : 'Used in Last Day'}

education_values_grouped = {'Left school before 16 years': 'Sin estudios',
                            'Left school at 16 years': 'Sin estudios',
                            'Left school at 17 years': 'Sin estudios',
                            'Left school at 18 years': 'Sin estudios',
                            'Some college or university, no certificate or degree': 'Estudiando',
                            'Professional certificate/diploma': 'Estudios de FP',
                            'University degree': 'Estudios superiores',
                            'Masters degree': 'Estudios superiores',
                            'Doctorate degree': 'Estudios superiores'}

drugs_values_grouped = {'Never Used' : 0,
                       'Used over a Decade Ago' : 0,
                       'Used in Last Decade' : 0,
                       'Used in Last Year' : 1,
                       'Used in Last Month' : 1,
                       'Used in Last Week' : 1,
                       'Used in Last Day' : 1}

drugs_to_delete = ['amphet', 'amyl', 'benzos', 'cannabis', 'cocaine',
                   'crack', 'ecstasy', 'heroin', 'ketamine',
                   'legal_highs', 'lsd', 'methadone', 'mushrooms', 'vsa']
