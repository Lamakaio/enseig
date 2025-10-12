# /// script
# requires-python = ">=3.13"
# dependencies = [
#     "pandas",
# ]
# ///
import pandas as pd

frame = pd.read_csv("nat2022.csv", on_bad_lines="skip", sep=";")

frame = frame["preusuel"].drop_duplicates()

frame = frame.map(lambda s: str(s).capitalize())

frame.to_csv("prenoms.csv", index=False)