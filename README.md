
# Automated Reverberator for Percussion



## Parameter Mapping

### Parameters
- [x] Gain
- [x] Pre-delay
- [x] Diffusion
- [x] Tail Decay
- [x] High Frequency Damping
- [x] High Frequency Cut


### Mapping

- Tempo &rarr; Diffusion and Decay
- Tempo &rarr; Pre-delay (Pedro Thesis)
- Crest &rarr; HF Damp
- Fixed Parameter &rarr; HF Cut
- Crest Factor &rarr; Gain

#### Tempo to preferred RT60

The mean tempo for each condition, (mean over 4 takes) and the RT60 of the space (at 1kHz) are significantly correlated
r = -0.8890 with a p =  0.00025. 

	F = fit(TEMPO1,RT(:,2),'poly1')
	F(x) = p1*x + p2
		p1 =        -1.1  (-1.527, -0.6727)
		p2 =       136.1  (84.5, 187.7)

#### RT60 to Diffusion and Tail Decay

	T = 942.4 + 0.00002*exp(20354 * decay) + 16170*exp(-6.446 * diffus);

#### HF Damping

HighFrequencyDamping = 1/(crest^2)

#### HF Cut

HighCutFrequency = 5000

#### Gain
gain = 1 /(crest^3)

## Citing
If any aspects of this code is used, please reference the following paper

Moffat, D. and Sandler, M., 2019, October. An Automated Approach to the Application of Reverberation. In Audio Engineering Society Convention 147.

```
@inproceedings{moffat19reverb,
	Address = {New York, USA},
	Author = {Moffat, David and Sandler, Mark B},
	Booktitle = {Audio Engineering Society Convention 147},
	Month = {October},
	Title = {An Automated Approach to the Application of Reverberation},
	Year = {2019}}
```

## Contact
Please contact me for licensing agreements, or for any questions.