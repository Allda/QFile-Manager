/********************************************************************************
** Form generated from reading UI file 'mainwindow.ui'
**
** Created by: Qt User Interface Compiler version 5.3.2
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINWINDOW_H
#define UI_MAINWINDOW_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QGroupBox>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QMenu>
#include <QtWidgets/QMenuBar>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QToolButton>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QAction *actionNew_file;
    QAction *actionOpen_file;
    QAction *actionClose_file;
    QAction *actionExit;
    QWidget *centralWidget;
    QGroupBox *groupBox;
    QToolButton *toolButton_3;
    QToolButton *toolButton;
    QToolButton *toolButton_2;
    QStatusBar *statusBar;
    QMenuBar *menuBar;
    QMenu *menuFile;
    QMenu *menuHelp;
    QMenu *menuSettings;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName(QStringLiteral("MainWindow"));
        MainWindow->resize(657, 408);
        actionNew_file = new QAction(MainWindow);
        actionNew_file->setObjectName(QStringLiteral("actionNew_file"));
        actionOpen_file = new QAction(MainWindow);
        actionOpen_file->setObjectName(QStringLiteral("actionOpen_file"));
        actionClose_file = new QAction(MainWindow);
        actionClose_file->setObjectName(QStringLiteral("actionClose_file"));
        actionExit = new QAction(MainWindow);
        actionExit->setObjectName(QStringLiteral("actionExit"));
        centralWidget = new QWidget(MainWindow);
        centralWidget->setObjectName(QStringLiteral("centralWidget"));
        groupBox = new QGroupBox(centralWidget);
        groupBox->setObjectName(QStringLiteral("groupBox"));
        groupBox->setGeometry(QRect(0, 0, 651, 101));
        toolButton_3 = new QToolButton(centralWidget);
        toolButton_3->setObjectName(QStringLiteral("toolButton_3"));
        toolButton_3->setGeometry(QRect(170, 130, 41, 61));
        QIcon icon;
        icon.addFile(QStringLiteral("icons/save.png"), QSize(), QIcon::Normal, QIcon::Off);
        toolButton_3->setIcon(icon);
        toolButton_3->setIconSize(QSize(128, 128));
        toolButton_3->setCheckable(false);
        toolButton_3->setToolButtonStyle(Qt::ToolButtonTextUnderIcon);
        toolButton_3->setAutoRaise(true);
        toolButton = new QToolButton(centralWidget);
        toolButton->setObjectName(QStringLiteral("toolButton"));
        toolButton->setGeometry(QRect(50, 140, 41, 61));
        QIcon icon1;
        icon1.addFile(QStringLiteral("../../icons/new.png"), QSize(), QIcon::Normal, QIcon::Off);
        toolButton->setIcon(icon1);
        toolButton->setIconSize(QSize(128, 128));
        toolButton->setCheckable(false);
        toolButton->setToolButtonStyle(Qt::ToolButtonTextUnderIcon);
        toolButton->setAutoRaise(true);
        toolButton_2 = new QToolButton(centralWidget);
        toolButton_2->setObjectName(QStringLiteral("toolButton_2"));
        toolButton_2->setGeometry(QRect(360, 130, 41, 61));
        QIcon icon2;
        icon2.addFile(QStringLiteral("icons/open.png"), QSize(), QIcon::Normal, QIcon::Off);
        toolButton_2->setIcon(icon2);
        toolButton_2->setIconSize(QSize(128, 128));
        toolButton_2->setCheckable(false);
        toolButton_2->setToolButtonStyle(Qt::ToolButtonTextUnderIcon);
        toolButton_2->setAutoRaise(true);
        MainWindow->setCentralWidget(centralWidget);
        statusBar = new QStatusBar(MainWindow);
        statusBar->setObjectName(QStringLiteral("statusBar"));
        MainWindow->setStatusBar(statusBar);
        menuBar = new QMenuBar(MainWindow);
        menuBar->setObjectName(QStringLiteral("menuBar"));
        menuBar->setGeometry(QRect(0, 0, 657, 21));
        menuFile = new QMenu(menuBar);
        menuFile->setObjectName(QStringLiteral("menuFile"));
        menuHelp = new QMenu(menuBar);
        menuHelp->setObjectName(QStringLiteral("menuHelp"));
        menuSettings = new QMenu(menuBar);
        menuSettings->setObjectName(QStringLiteral("menuSettings"));
        MainWindow->setMenuBar(menuBar);

        menuBar->addAction(menuFile->menuAction());
        menuBar->addAction(menuSettings->menuAction());
        menuBar->addAction(menuHelp->menuAction());
        menuFile->addAction(actionNew_file);
        menuFile->addAction(actionOpen_file);
        menuFile->addAction(actionClose_file);
        menuFile->addSeparator();
        menuFile->addAction(actionExit);

        retranslateUi(MainWindow);

        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QApplication::translate("MainWindow", "MainWindow", 0));
        actionNew_file->setText(QApplication::translate("MainWindow", "New file", 0));
        actionOpen_file->setText(QApplication::translate("MainWindow", "Open file", 0));
        actionClose_file->setText(QApplication::translate("MainWindow", "Close file", 0));
        actionExit->setText(QApplication::translate("MainWindow", "Exit", 0));
        groupBox->setTitle(QApplication::translate("MainWindow", "GroupBox", 0));
        toolButton_3->setText(QApplication::translate("MainWindow", "Save", 0));
        toolButton_3->setShortcut(QString());
        toolButton->setText(QApplication::translate("MainWindow", "New", 0));
        toolButton->setShortcut(QString());
        toolButton_2->setText(QApplication::translate("MainWindow", "Open", 0));
        toolButton_2->setShortcut(QString());
        menuFile->setTitle(QApplication::translate("MainWindow", "File", 0));
        menuHelp->setTitle(QApplication::translate("MainWindow", "Help", 0));
        menuSettings->setTitle(QApplication::translate("MainWindow", "Settings", 0));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H
