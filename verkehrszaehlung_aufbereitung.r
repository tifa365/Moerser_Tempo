library(ggplot2); library(scales); library(grid); library(RColorBrewer); library(Cairo)
# Für Cairo muss libcairo2-dev installiert sein, siehe http://www.cairographics.org/download/ und http://is-r.tumblr.com/post/33421588764/using-cairographics-with-ggsave

ackerstr <- read.csv("ackerstrasse_40_t30_05112014.txt",header=FALSE,sep=";")
names(ackerstr) <- c("date","place","tempo","length","direction")
ackerstr$tempoclass <- cut(ackerstr$tempo, breaks = c(0,30,36,Inf), labels=c("<30 km/h", "30–36 km/h", ">36 km/h"))
ackerstr$vehicleclass <-cut(ackerstr$length, breaks = c(0,8,12, Inf), labels=c("PKW", "LKW", "Lastzug"))
ackerstr$datetime <- as.POSIXct(ackerstr$date,format="%d.%m.%y %H:%M:%S")


aubruchsweg <- read.csv("aubruchsweg_22-24_t30_20102014.txt",header=FALSE,sep=";")
names(aubruchsweg) <- c("date","place","tempo","length","direction")
aubruchsweg$tempoclass <- cut(aubruchsweg$tempo, breaks = c(0,30,36,Inf), labels=c("<30 km/h", "30–36 km/h", ">36 km/h"))
aubruchsweg$vehicleclass <-cut(aubruchsweg$length, breaks = c(0,8,12, Inf), labels=c("PKW", "LKW", "Lastzug"))
aubruchsweg$datetime <- as.POSIXct(aubruchsweg$date,format="%d.%m.%y %H:%M:%S")

boschheideweg <- read.csv("boschheideweg_36_t30_24112014.txt",header=FALSE,sep=";")
names(boschheideweg) <- c("date","place","tempo","length","direction")
boschheideweg$tempoclass <- cut(boschheideweg$tempo, breaks = c(0,30,36,Inf), labels=c("<30 km/h", "30–36 km/h", ">36 km/h"))
boschheideweg$vehicleclass <-cut(boschheideweg$length, breaks = c(0,8,12, Inf), labels=c("PKW", "LKW", "Lastzug"))
boschheideweg$datetime <- as.POSIXct(boschheideweg$date,format="%d.%m.%y %H:%M:%S")

endstr <- read.csv("endstrasse_17_t50_03112014.txt",header=FALSE,sep=";")
names(endstr) <- c("date","place","tempo","length","direction")
endstr$tempoclass <- cut(endstr$tempo, breaks = c(0,50,56,Inf), labels=c("<50 km/h", "50–56 km/h", ">56 km/h"))
endstr$vehicleclass <-cut(endstr$length, breaks = c(0,8,12, Inf), labels=c("PKW", "LKW", "Lastzug"))
endstr$datetime <- as.POSIXct(endstr$date,format="%d.%m.%y %H:%M:%S")

eupenerstr <- read.csv("eupener_strasse_2a_t30_22102014.txt",header=FALSE,sep=";")
names(eupenerstr) <- c("date","place","tempo","length","direction")
eupenerstr$tempoclass <- cut(eupenerstr$tempo, breaks = c(0,30,36,Inf), labels=c("<30 km/h", "30–36 km/h", ">36 km/h"))
eupenerstr$vehicleclass <-cut(eupenerstr$length, breaks = c(0,8,12, Inf), labels=c("PKW", "LKW", "Lastzug"))
eupenerstr$datetime <- as.POSIXct(eupenerstr$date,format="%d.%m.%y %H:%M:%S")

friedenstr <- read.csv("friedenstrasse_5_t30_14052014.txt",header=FALSE,sep=";")
names(friedenstr) <- c("date","place","tempo","length","direction")
friedenstr$tempoclass <- cut(friedenstr$tempo, breaks = c(0,30,36,Inf), labels=c("<30 km/h", "30–36 km/h", ">36 km/h"))
friedenstr$vehicleclass <-cut(friedenstr$length, breaks = c(0,8,12, Inf), labels=c("PKW", "LKW", "Lastzug"))
friedenstr$datetime <- as.POSIXct(friedenstr$date,format="%d.%m.%y %H:%M:%S")

kirchweg <- read.csv("kirchweg_5_t30_08122014.txt",header=FALSE,sep=";")
names(kirchweg) <- c("date","place","tempo","length","direction")
kirchweg$tempoclass <- cut(kirchweg$tempo, breaks = c(0,30,36,Inf), labels=c("<30 km/h", "30–36 km/h", ">36 km/h"))
kirchweg$vehicleclass <-cut(kirchweg$length, breaks = c(0,8,12, Inf), labels=c("PKW", "LKW", "Lastzug"))
kirchweg$datetime <- as.POSIXct(kirchweg$date,format="%d.%m.%y %H:%M:%S")

kirschenallee <- read.csv("kirschenallee_33_t30_28082014.txt",header=FALSE,sep=";")
names(kirschenallee) <- c("date","place","tempo","length","direction")
kirschenallee$tempoclass <- cut(kirschenallee$tempo, breaks = c(0,30,36,Inf), labels=c("<30 km/h", "30–36 km/h", ">36 km/h"))
kirschenallee$vehicleclass <-cut(kirschenallee$length, breaks = c(0,8,12, Inf), labels=c("PKW", "LKW", "Lastzug"))
kirschenallee$datetime <- as.POSIXct(kirschenallee$date,format="%d.%m.%y %H:%M:%S")

landwehrstr <- read.csv("landwehrstrasse_57_t30_15122014.txt",header=FALSE,sep=";")
names(landwehrstr) <- c("date","place","tempo","length","direction")
landwehrstr$tempoclass <- cut(landwehrstr$tempo, breaks = c(0,30,36,Inf), labels=c("<30 km/h", "30–36 km/h", ">36 km/h"))
landwehrstr$vehicleclass <-cut(landwehrstr$length, breaks = c(0,8,12, Inf), labels=c("PKW", "LKW", "Lastzug"))
landwehrstr$datetime <- as.POSIXct(landwehrstr$date,format="%d.%m.%y %H:%M:%S")

pattbergstr <- read.csv("pattbergstrasse_12-16_t50_03122014.txt",header=FALSE,sep=";")
names(pattbergstr) <- c("date","place","tempo","length","direction")
pattbergstr$tempoclass <- cut(pattbergstr$tempo, breaks = c(0,50,56,Inf), labels=c("<50 km/h", "50–56 km/h", ">56 km/h"))
pattbergstr$vehicleclass <-cut(pattbergstr$length, breaks = c(0,8,12, Inf), labels=c("PKW", "LKW", "Lastzug"))
pattbergstr$datetime <- as.POSIXct(pattbergstr$date,format="%d.%m.%y %H:%M:%S")

roemerstr <- read.csv("roemerstrasse_501_t30_04062014.txt",header=FALSE,sep=";")
names(roemerstr) <- c("date","place","tempo","length","direction")
roemerstr$tempoclass <- cut(roemerstr$tempo, breaks = c(0,30,36,Inf), labels=c("<30 km/h", "30–36 km/h", ">36 km/h"))
roemerstr$vehicleclass <-cut(roemerstr$length, breaks = c(0,8,12, Inf), labels=c("PKW", "LKW", "Lastzug"))
roemerstr$datetime <- as.POSIXct(roemerstr$date,format="%d.%m.%y %H:%M:%S")

ruhrstr <- read.csv("ruhrstrasse_58_t30_14042014.txt",header=FALSE,sep=";")
names(ruhrstr) <- c("date","place","tempo","length","direction")
ruhrstr$tempoclass <- cut(ruhrstr$tempo, breaks = c(0,30,36,Inf), labels=c("<30 km/h", "30–36 km/h", ">36 km/h"))
ruhrstr$vehicleclass <-cut(ruhrstr$length, breaks = c(0,8,12, Inf), labels=c("PKW", "LKW", "Lastzug"))
ruhrstr$datetime <- as.POSIXct(ruhrstr$date,format="%d.%m.%y %H:%M:%S")

taubenstr <- read.csv("taubenstrasse_9_t30_01122014.txt",header=FALSE,sep=";")
names(taubenstr) <- c("date","place","tempo","length","direction")
taubenstr$tempoclass <- cut(taubenstr$tempo, breaks = c(0,30,36,Inf), labels=c("<30 km/h", "30–36 km/h", ">36 km/h"))
taubenstr$vehicleclass <-cut(taubenstr$length, breaks = c(0,8,12, Inf), labels=c("PKW", "LKW", "Lastzug"))
taubenstr$datetime <- as.POSIXct(taubenstr$date,format="%d.%m.%y %H:%M:%S")

vinnerstr <- read.csv("vinner_strasse_42_t30_27102014.txt",header=FALSE,sep=";")
names(vinnerstr) <- c("date","place","tempo","length","direction")
vinnerstr$tempoclass <- cut(vinnerstr$tempo, breaks = c(0,30,36,Inf), labels=c("<30 km/h", "30–36 km/h", ">36 km/h"))
vinnerstr$vehicleclass <-cut(vinnerstr$length, breaks = c(0,8,12, Inf), labels=c("PKW", "LKW", "Lastzug"))
vinnerstr$datetime <- as.POSIXct(vinnerstr$date,format="%d.%m.%y %H:%M:%S")


 # Plot der Tabelle; x-Achse ist das Datum in DateTime aufbereitet, y-Achse das Tempo, Einfärbung der Punkte nach Geschwindigkeitsklassifizierung
ggplot(eupenerstr, aes(x=datetime, y=tempo, colour = tempoclass)) +
# Punkte sind semitransparent, Größe abhängig von der Fahrzeugklasse
  geom_point(alpha=0.2, aes(size=vehicleclass)) +
# Farbenblindenfreundliche Palette, siehe http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/#a-colorblind-friendly-palette
  scale_color_manual(values= c("#009E73", "#E69F00", "#D55E00"), name="Geschwindigkeit") +
  # Hilfslinie bei 30 km/h
  geom_hline(yintercept=30, size=0.4, color="#efefef") +
  # Hilfslinie auf dem Nullpunkt der Y-Achse
  geom_hline(yintercept=0, size=0.1, color="black") +
  # Trendlinie mit Generalized Additive Model, siehe http://minimaxir.com/2015/02/ggplot-tutorial/
  geom_smooth(alpha=0.25, color="black", fill="black") +
  # Achsenbeschriftungen
  labs(title="Geschwindigkeitsmessung in der Eupener Straße", x="Zeit", y="Geschwindigkeit", size="Fahrzeugart") +
  guides(colour = guide_legend(override.aes = list(size=5 ,alpha=1))) + 
  scale_x_datetime(labels = date_format("%d.%m %H:%M"))

ggsave("eupenerstr.png", width=8, height=4, dpi=300, type="cairo-png")


ggplot(ackerstr, aes(x=datetime, y=tempo, colour = tempoclass)) +
  geom_point(alpha=0.2, aes(size=vehicleclass)) +
  scale_color_manual(values= c("#009E73", "#E69F00", "#D55E00"), name="Geschwindigkeit") +
  geom_hline(yintercept=30, size=0.4, color="#efefef") +
  geom_hline(yintercept=0, size=0.1, color="black") +
  geom_smooth(alpha=0.25, color="black", fill="black") +
  labs(title="Geschwindigkeitsmessung in der Ackerstraße", x="Zeit", y="Geschwindigkeit", size="Fahrzeugart") +
  guides(colour = guide_legend(override.aes = list(size=5 ,alpha=1))) + 
  scale_x_datetime(labels = date_format("%d.%m %H:%M"))

ggsave("ackerstr.png", width=8, height=4, dpi=300, type="cairo-png")

ggplot(aubruchsweg, aes(x=datetime, y=tempo, colour = tempoclass)) +
  geom_point(alpha=0.2, aes(size=vehicleclass)) +
  scale_color_manual(values= c("#009E73", "#E69F00", "#D55E00"), name="Geschwindigkeit") +
  geom_hline(yintercept=30, size=0.4, color="#efefef") +
  geom_hline(yintercept=0, size=0.1, color="black") +
  geom_smooth(alpha=0.25, color="black", fill="black") +
  labs(title="Geschwindigkeitsmessung im Aubruchsweg", x="Zeit", y="Geschwindigkeit", size="Fahrzeugart") +
  guides(colour = guide_legend(override.aes = list(size=5 ,alpha=1))) + 
  scale_x_datetime(labels = date_format("%d.%m %H:%M"))

ggsave("aubruchsweg.png", width=8, height=4, dpi=300, type="cairo-png")


ggplot(boschheideweg, aes(x=datetime, y=tempo, colour = tempoclass)) +
  geom_point(alpha=0.2, aes(size=vehicleclass)) +
  scale_color_manual(values= c("#009E73", "#E69F00", "#D55E00"), name="Geschwindigkeit") +
  geom_hline(yintercept=30, size=0.4, color="#efefef") +
  geom_hline(yintercept=0, size=0.1, color="black") +
  geom_smooth(alpha=0.25, color="black", fill="black") +
  labs(title="Geschwindigkeitsmessung im Boschheideweg", x="Zeit", y="Geschwindigkeit", size="Fahrzeugart") +
  guides(colour = guide_legend(override.aes = list(size=5 ,alpha=1))) + 
  scale_x_datetime(labels = date_format("%d.%m %H:%M"))

ggsave("boschheideweg.png", width=8, height=4, dpi=300, type="cairo-png")


ggplot(endstr, aes(x=datetime, y=tempo, colour = tempoclass)) +
  geom_point(alpha=0.2, aes(size=vehicleclass)) +
  scale_color_manual(values= c("#009E73", "#E69F00", "#D55E00"), name="Geschwindigkeit") +
  geom_hline(yintercept=30, size=0.4, color="#efefef") +
  geom_hline(yintercept=0, size=0.1, color="black") +
  geom_smooth(alpha=0.25, color="black", fill="black") +
  labs(title="Geschwindigkeitsmessung in der Endstraße", x="Zeit", y="Geschwindigkeit", size="Fahrzeugart") +
  guides(colour = guide_legend(override.aes = list(size=5 ,alpha=1))) + 
  scale_x_datetime(labels = date_format("%d.%m %H:%M"))

ggsave("endstr.png", width=8, height=4, dpi=300, type="cairo-png")


ggplot(friedenstr, aes(x=datetime, y=tempo, colour = tempoclass)) +
  geom_point(alpha=0.2, aes(size=vehicleclass)) +
  scale_color_manual(values= c("#009E73", "#E69F00", "#D55E00"), name="Geschwindigkeit") +
  geom_hline(yintercept=30, size=0.4, color="#efefef") +
  geom_hline(yintercept=0, size=0.1, color="black") +
  geom_smooth(alpha=0.25, color="black", fill="black") +
  labs(title="Geschwindigkeitsmessung in der Friedenstraße", x="Zeit", y="Geschwindigkeit", size="Fahrzeugart") +
  guides(colour = guide_legend(override.aes = list(size=5 ,alpha=1))) + 
  scale_x_datetime(labels = date_format("%d.%m %H:%M"))

ggsave("friedenstr.png", width=8, height=4, dpi=300, type="cairo-png")


ggplot(kirchweg, aes(x=datetime, y=tempo, colour = tempoclass)) +
  geom_point(alpha=0.2, aes(size=vehicleclass)) +
  scale_color_manual(values= c("#009E73", "#E69F00", "#D55E00"), name="Geschwindigkeit") +
  geom_hline(yintercept=30, size=0.4, color="#efefef") +
  geom_hline(yintercept=0, size=0.1, color="black") +
  geom_smooth(alpha=0.25, color="black", fill="black") +
  labs(title="Geschwindigkeitsmessung im Kirchweg", x="Zeit", y="Geschwindigkeit", size="Fahrzeugart") +
  guides(colour = guide_legend(override.aes = list(size=5 ,alpha=1))) + 
  scale_x_datetime(labels = date_format("%d.%m %H:%M"))

ggsave("kirchweg.png", width=8, height=4, dpi=300, type="cairo-png")


ggplot(kirschenallee, aes(x=datetime, y=tempo, colour = tempoclass)) +
  geom_point(alpha=0.2, aes(size=vehicleclass)) +
  scale_color_manual(values= c("#009E73", "#E69F00", "#D55E00"), name="Geschwindigkeit") +
  geom_hline(yintercept=30, size=0.4, color="#efefef") +
  geom_hline(yintercept=0, size=0.1, color="black") +
  geom_smooth(alpha=0.25, color="black", fill="black") +
  labs(title="Geschwindigkeitsmessung in der Kirschenallee", x="Zeit", y="Geschwindigkeit", size="Fahrzeugart") +
  guides(colour = guide_legend(override.aes = list(size=5 ,alpha=1))) + 
  scale_x_datetime(labels = date_format("%d.%m %H:%M"))

ggsave("kirschenallee.png", width=8, height=4, dpi=300, type="cairo-png")


ggplot(landwehrstr, aes(x=datetime, y=tempo, colour = tempoclass)) +
  geom_point(alpha=0.2, aes(size=vehicleclass)) +
  scale_color_manual(values= c("#009E73", "#E69F00", "#D55E00"), name="Geschwindigkeit") +
  geom_hline(yintercept=30, size=0.4, color="#efefef") +
  geom_hline(yintercept=0, size=0.1, color="black") +
  geom_smooth(alpha=0.25, color="black", fill="black") +
  labs(title="Geschwindigkeitsmessung in der Landwehrstraße", x="Zeit", y="Geschwindigkeit", size="Fahrzeugart") +
  guides(colour = guide_legend(override.aes = list(size=5 ,alpha=1))) + 
  scale_x_datetime(labels = date_format("%d.%m %H:%M"))

ggsave("landwehrstr.png", width=8, height=4, dpi=300, type="cairo-png")


ggplot(pattbergstr, aes(x=datetime, y=tempo, colour = tempoclass)) +
  geom_point(alpha=0.2, aes(size=vehicleclass)) +
  scale_color_manual(values= c("#009E73", "#E69F00", "#D55E00"), name="Geschwindigkeit") +
  geom_hline(yintercept=30, size=0.4, color="#efefef") +
  geom_hline(yintercept=0, size=0.1, color="black") +
  geom_smooth(alpha=0.25, color="black", fill="black") +
  labs(title="Geschwindigkeitsmessung in der Pattbergstraße", x="Zeit", y="Geschwindigkeit", size="Fahrzeugart") +
  guides(colour = guide_legend(override.aes = list(size=5 ,alpha=1))) + 
  scale_x_datetime(labels = date_format("%d.%m %H:%M"))

ggsave("pattbergstr.png", width=8, height=4, dpi=300, type="cairo-png")


ggplot(roemerstr, aes(x=datetime, y=tempo, colour = tempoclass)) +
  geom_point(alpha=0.2, aes(size=vehicleclass)) +
  scale_color_manual(values= c("#009E73", "#E69F00", "#D55E00"), name="Geschwindigkeit") +
  geom_hline(yintercept=30, size=0.4, color="#efefef") +
  geom_hline(yintercept=0, size=0.1, color="black") +
  geom_smooth(alpha=0.25, color="black", fill="black") +
  labs(title="Geschwindigkeitsmessung in der Römerstraße", x="Zeit", y="Geschwindigkeit", size="Fahrzeugart") +
  guides(colour = guide_legend(override.aes = list(size=5 ,alpha=1))) + 
  scale_x_datetime(labels = date_format("%d.%m %H:%M"))

ggsave("roemerstr.png", width=8, height=4, dpi=300, type="cairo-png")


ggplot(ruhrstr, aes(x=datetime, y=tempo, colour = tempoclass)) +
  geom_point(alpha=0.2, aes(size=vehicleclass)) +
  scale_color_manual(values= c("#009E73", "#E69F00", "#D55E00"), name="Geschwindigkeit") +
  geom_hline(yintercept=30, size=0.4, color="#efefef") +
  geom_hline(yintercept=0, size=0.1, color="black") +
  geom_smooth(alpha=0.25, color="black", fill="black") +
  labs(title="Geschwindigkeitsmessung in der Ruhrstraße", x="Zeit", y="Geschwindigkeit", size="Fahrzeugart") +
  guides(colour = guide_legend(override.aes = list(size=5 ,alpha=1))) + 
  scale_x_datetime(labels = date_format("%d.%m %H:%M"))

ggsave("ruhrstr.png", width=8, height=4, dpi=300, type="cairo-png")


ggplot(taubenstr, aes(x=datetime, y=tempo, colour = tempoclass)) +
  geom_point(alpha=0.2, aes(size=vehicleclass)) +
  scale_color_manual(values= c("#009E73", "#E69F00", "#D55E00"), name="Geschwindigkeit") +
  geom_hline(yintercept=30, size=0.4, color="#efefef") +
  geom_hline(yintercept=0, size=0.1, color="black") +
  geom_smooth(alpha=0.25, color="black", fill="black") +
  labs(title="Geschwindigkeitsmessung in der Taubenstraße", x="Zeit", y="Geschwindigkeit", size="Fahrzeugart") +
  guides(colour = guide_legend(override.aes = list(size=5 ,alpha=1))) + 
  scale_x_datetime(labels = date_format("%d.%m %H:%M"))

ggsave("taubenstr.png", width=8, height=4, dpi=300, type="cairo-png")


ggplot(vinnerstr, aes(x=datetime, y=tempo, colour = tempoclass)) +
  geom_point(alpha=0.2, aes(size=vehicleclass)) +
  scale_color_manual(values= c("#009E73", "#E69F00", "#D55E00"), name="Geschwindigkeit") +
  geom_hline(yintercept=30, size=0.4, color="#efefef") +
  geom_hline(yintercept=0, size=0.1, color="black") +
  geom_smooth(alpha=0.25, color="black", fill="black") +
  labs(title="Geschwindigkeitsmessung in der Vinner Straße", x="Zeit", y="Geschwindigkeit", size="Fahrzeugart") +
  guides(colour = guide_legend(override.aes = list(size=5 ,alpha=1))) + 
  scale_x_datetime(labels = date_format("%d.%m %H:%M"))

ggsave("vinnerstr.png", width=8, height=4, dpi=300, type="cairo-png")
