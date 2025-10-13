library(ggnewscale)
library(ggrepel)
library(readxl)
library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(stringr)

data1 <- read_excel("/Users/mahek/Documents/TAU/LCRB/Excels & Words/Groupsfile1.xlsx", sheet = "Sheet1")
data2 <- read_excel("/Users/mahek/Documents/TAU/LCRB/Excels & Words/Groupsfile1.xlsx", sheet = "Sheet2")
data3 <- read_excel("/Users/mahek/Documents/TAU/LCRB/Excels & Words/Groupsfile1.xlsx", sheet = "Sheet3")

data_combined <- rbind(
  data.frame(Value = data1$log, Gene = data1$gene, Group = "Mitochondrial genes\n(84 binding sites)"),
  data.frame(Value = data2$log, Gene = data2$gene, Group = "Mitochondrial pseudogenes\n(329 binding sites)"),
  data.frame(Value = data3$log, Gene = data3$gene, Group = "Nuclear genes\n(1290 binding sites)")
)
 
data_combined <- na.omit(data_combined)

outliers <- data_combined %>%
  group_by(Group) %>% 
  mutate(
    IQR_value = IQR(Value, na.rm = TRUE), 
    lower_bound = quantile(Value, 0.25, na.rm = TRUE) - 1.5 * IQR_value, 
    upper_bound = quantile(Value, 0.75, na.rm = TRUE) + 1.5 * IQR_value,
    is_outlier = Value < lower_bound | Value > upper_bound
  ) %>%
  filter(is_outlier) 
 
legend_labels <- c("Ribosomal RNA", "Ribosomal proteins", "Tubulin", "Histones") 
 
outliers_to_label <- outliers %>% filter(!Gene %in% legend_labels) 
outliers_not_to_label <- outliers %>% filter(Gene %in% legend_labels)
 
custom_colors <- c("Ribosomal RNA" = "blue", "Ribosomal proteins" = "red", "Tubulin" = "green", "Histones" = "purple") 
 
other_colors <- rep("black", length(unique(outliers_to_label$Gene))) 
names(other_colors) <- unique(outliers_to_label$Gene) 
 
boxplot_fill_color <- "lightblue"
boxplot_outline_color <- "black"
ggplot(data_combined, aes(x = Group, y = Value)) +
  geom_boxplot(outlier.shape = NA, width = 0.3, fill = boxplot_fill_color, color = boxplot_outline_color, alpha = 0.5) + 
 
  geom_jitter(data = outliers_to_label, width = 0.2, height = 0, show.legend = FALSE) + 
  geom_text_repel(data = outliers_to_label, aes(label = Gene), color = "black", size = 3, segment.color = NA, point.padding = 0.05, box.padding = 0.05, nudge_y = 0.1) + 
  scale_color_manual(values = other_colors) +
  new_scale_color() +
 
  geom_jitter(data = outliers_not_to_label, aes(color = Gene), width = 0.2, height = 0, show.legend = TRUE) +
  scale_color_manual(values = custom_colors, name = NULL) + 
 
  labs(x = NULL, y = "Binding Intensity\n(Reads per cluster length)", title = "Boxplot of RNA-binding protein: UPF0598 protein C8orf82") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    axis.title.x = element_text(size = 16, face = "bold"),
    axis.title.y = element_text(size = 16, face = "bold"),
    axis.text.x = element_text(size = 12, face = "bold"), 
    axis.text.y = element_text(size = 12, face = "bold"),
    panel.grid.major = element_line(color = "grey80"), 
    panel.grid.minor = element_line(color = "grey90"), 
    axis.line = element_line(color = "black"), 
    legend.background = element_rect(color = "black", fill = "white", size = 0.5, linetype = "solid")
)