---
title: 自定义widget折叠
date: 2019-01-08 21:07:07
categories:
- python
- PyQt5
tags:
- PyQt5
---

# 一、功能说明：
- 想点击一个按钮，折叠/展开一个widget

# 二、预览
![fold折叠QWidget](./../../image/20190109-FoldWidget.gif)

# 三、PyQt5代码如下：
```python
# -*- coding:utf-8 -*-
"""
@Author: lamborghini
@Date: 2019-01-08 21:07:07
@Desc: 可折叠widget
"""

import sys
from PyQt5.QtWidgets import (QPushButton, QDialog, QTreeWidget,
                             QTreeWidgetItem, QVBoxLayout,
                             QHBoxLayout, QFrame, QLabel,
                             QApplication, QSpacerItem,
                             QSizePolicy, QHeaderView)


class SectionExpandButton(QPushButton):
    """
    a QPushbutton that can expand or collapse its section
    """

    def __init__(self, item, text="", parent=None):
        super().__init__(text, parent)
        self.section = item
        self.clicked.connect(self.on_clicked)

    def on_clicked(self):
        """
        toggle expand/collapse of section by clicking
        """
        if self.section.isExpanded():
            self.section.setExpanded(False)
        else:
            self.section.setExpanded(True)


class CollapsibleDialog(QDialog):
    """
    a dialog to which collapsible sections can be added;
    subclass and reimplement define_sections() to define sections and
        add them as (title, widget) tuples to self.sections
    """

    def __init__(self):
        super().__init__()
        self.tree = QTreeWidget()
        self.tree.setHeaderHidden(True)
        layout = QVBoxLayout()
        item = QSpacerItem(67, 20, QSizePolicy.Expanding, QSizePolicy.Minimum)
        layout.addWidget(self.tree)
        layout.addItem(item)
        self.setLayout(layout)
        self.tree.setIndentation(0)

        self.sections = []
        self.define_sections()
        self.add_sections()

    def add_sections(self):
        """
        adds a collapsible sections for every 
        (title, widget) tuple in self.sections
        """
        for (title, widget) in self.sections:
            button1 = self.add_button(title)
            section1 = self.add_widget(button1, widget)
            button1.addChild(section1)

    def define_sections(self):
        """
        reimplement this to define all your sections
        and add them as (title, widget) tuples to self.sections
        """
        for x in range(3):
            widget = QFrame(self.tree)
            vbox = QVBoxLayout(widget)  # fold widget
            for y in range(5):
                sName = "%s_Test%s" % (x, y)
                label = QLabel(sName, widget)
                vbox.addWidget(label)
            widget.setLayout(vbox)
            title = "Section %s" % x
            self.sections.append((title, widget))

    def define_sections2(self):
        """
        reimplement this to define all your sections
        and add them as (title, widget) tuples to self.sections
        """
        for x in range(3):
            widget = QTreeWidget(self.tree) # fold QTreeWidget
            widget.setHeaderHidden(True)
            widget.header().setSectionResizeMode(QHeaderView.Stretch)
            for y in range(5):
                sName = "%s_Test%s" % (x, y)
                item = QTreeWidgetItem(widget)
                item.setText(0, sName)
            title = "Section %s" % x
            self.sections.append((title, widget))

    def add_button(self, title):
        """
        creates a QTreeWidgetItem containing a button 
        to expand or collapse its section
        """
        item = QTreeWidgetItem()
        self.tree.addTopLevelItem(item)
        self.tree.setItemWidget(item, 0, SectionExpandButton(item, text=title))
        return item

    def add_widget(self, button, widget):
        """
        creates a QWidgetItem containing the widget,
        as child of the button-QWidgetItem
        """
        section = QTreeWidgetItem(button)
        section.setDisabled(True)
        self.tree.setItemWidget(section, 0, widget)
        return section


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = CollapsibleDialog()
    window.show()
    sys.exit(app.exec_())
```
