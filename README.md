# Project Manager Neovim Plugin

A Neovim plugin to manage and switch between projects effortlessly, while keeping track of project-specific settings, references, and more.
Features


1. Project List Management

    Store the name and path of multiple projects for easy access.
    Quickly switch between projects using a simple interface.

2. Project-Specific Environment Variables

    Define environment variables for each project that are automatically applied when switching.
    No need to manually set environment variables each time you work on different projects.

3. Project-Specific Notes

    Write and store personal README files for each project. Perfect for reminders or documenting special instructions.
    These notes are private and specific to your workflow.

4. Reference Management

    Store important project links such as:
        Staging host URL
        GitLab repositories
        Trello boards or other project management tools.
    Easily access and manage these references from within Neovim.

5. Label and Search Projects

    Add labels to your projects for better organization (e.g., 'Work', 'Personal', 'Urgent').
    Quickly search through projects based on labels or keywords.

# Usage

    Add a project: :ProjectAdd
    Switch to a project: :ProjectSwitch <project_name>
    Edit project settings: :ProjectSettings <project_name>
    Add project-specific environment variables: :ProjectEnv <project_name>

# Idea: Project Templates

Maybe adding templates for common project types (like a Django app, a Node.js app, etc.) that can automatically prefill certain settings like environment variables, directories, or references. or writing a syntax to be able to create templates
